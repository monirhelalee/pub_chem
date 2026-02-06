import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pub_chem/app/config/env.dart';
import 'package:pub_chem/app/config/service_locator.dart';
import 'package:pub_chem/app/network_service/end_points.dart';
import 'package:pub_chem/app/router/app_routes.dart';
import 'package:pub_chem/app/utils/time_ago_utils.dart';
import 'package:pub_chem/compound_details/domain/entities/compound.dart';
import 'package:pub_chem/compound_details/view/bloc/compound_details_bloc.dart';
import 'package:pub_chem/compound_details/view/bloc/compound_details_event.dart';
import 'package:pub_chem/compound_details/view/bloc/compound_details_state.dart';
import 'package:pub_chem/l10n/l10n.dart';
import 'package:pub_chem/search/data/services/recent_search_service.dart';
import 'package:pub_chem/search/domain/entities/recent_search.dart';
import 'package:pub_chem/search/view/bloc/recent_search_bloc.dart';
import 'package:pub_chem/search/view/bloc/recent_search_event.dart';
import 'package:pub_chem/search/view/bloc/recent_search_state.dart';
import 'package:pub_chem/search/view/widgets/search_compound_loading_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final RecentSearchService _recentSearchService = sl<RecentSearchService>();
  String? _currentSearchText;
  late CompoundDetailsBloc _compoundDetailsBloc;
  late RecentSearchBloc _recentSearchBloc;

  @override
  void initState() {
    super.initState();
    _compoundDetailsBloc = sl<CompoundDetailsBloc>();
    _recentSearchBloc = sl<RecentSearchBloc>()
      ..add(const LoadRecentSearchEvent());
  }

  Future<void> _saveSearch(String searchText, bool isSuccess) async {
    final search = RecentSearch(
      searchText: searchText,
      timestamp: DateTime.now(),
      isSuccess: isSuccess,
    );
    await _recentSearchService.addRecentSearch(search);
    _recentSearchBloc.add(const LoadRecentSearchEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.search),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Hero(
            tag: 'search_bar',
            child: SearchBar(
              controller: _searchController,
              trailing: [
                InkWell(
                  onTap: () {
                    if (_searchController.text.isNotEmpty) {
                      _performSearch(_searchController.text);
                    }
                  },
                  child: const Icon(Icons.search),
                ),
              ],
              hintText: l10n.searchForCompounds,
              padding: WidgetStateProperty.all(
                const EdgeInsets.only(left: 16, right: 16),
              ),
              elevation: WidgetStateProperty.all(0),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _performSearch(value);
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          BlocListener<CompoundDetailsBloc, CompoundDetailsState>(
            bloc: _compoundDetailsBloc,
            listener: (context, state) async {
              await state.whenOrNull(
                loaded: (compound) async {
                  if (_currentSearchText != null) {
                    await _saveSearch(_currentSearchText!, true);
                    _currentSearchText = null;
                  }
                },
                error: (message) async {
                  if (_currentSearchText != null) {
                    await _saveSearch(_currentSearchText!, false);
                    _currentSearchText = null;
                  }
                },
              );
            },
            child: BlocBuilder<CompoundDetailsBloc, CompoundDetailsState>(
              bloc: _compoundDetailsBloc,
              builder: (context, state) {
                return state.when(
                  initial: SizedBox.new,
                  loading: () => const SearchCompoundLoadingWidget(),
                  loaded: _buildCompoundResult,
                  error: _buildError,
                );
              },
            ),
          ),
          _buildRecentSearchesSection(),
        ],
      ),
    );
  }

  void _performSearch(String searchText) {
    setState(() {
      _currentSearchText = searchText;
    });
    _compoundDetailsBloc = sl<CompoundDetailsBloc>()
      ..add(
        LoadCompoundDetailsEvent(compoundName: searchText),
      );
  }

  Widget _buildRecentSearchesSection() {
    final l10n = context.l10n;
    return BlocBuilder<RecentSearchBloc, RecentSearchState>(
      bloc: _recentSearchBloc,
      builder: (context, state) {
        return state.when(
          initial: SizedBox.new,
          loading: () => const SearchCompoundLoadingWidget(),
          loaded: (value) => Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.history,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          l10n.recentSearch,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    if (value.isNotEmpty)
                      TextButton.icon(
                        onPressed: () async {
                          await _recentSearchService.clearRecentSearches();
                          _recentSearchBloc.add(
                            const LoadRecentSearchEvent(),
                          );
                        },
                        icon: const Icon(Icons.clear_all, size: 16),
                        label: Text(l10n.clear),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                if (value.isEmpty)
                  Center(
                    child: Text(
                      l10n.noRecentSearchFound,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      itemCount: value.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final search = value[index];
                        return Card(
                          elevation: 0.5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            onTap: () {
                              _searchController.text = search.searchText;
                              _performSearch(search.searchText);
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: search.isSuccess
                                          ? Colors.green.withOpacity(0.1)
                                          : Theme.of(
                                              context,
                                            ).colorScheme.error.withOpacity(
                                              0.1,
                                            ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      search.isSuccess
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      color: search.isSuccess
                                          ? Colors.green
                                          : Theme.of(context).colorScheme.error,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          search.searchText,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          search.isSuccess
                                              ? TimeAgoUtils.getTimeAgo(
                                                  search.timestamp,
                                                  context,
                                                )
                                              : l10n.notFound,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: search.isSuccess
                                                    ? Theme.of(
                                                            context,
                                                          )
                                                          .colorScheme
                                                          .onSurfaceVariant
                                                    : Theme.of(
                                                        context,
                                                      ).colorScheme.error,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.search,
                                    size: 16,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          error: _buildError,
        );
        // return Expanded(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const Divider(height: 32),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Row(
        //             children: [
        //               Icon(
        //                 Icons.history,
        //                 color: Theme.of(context).colorScheme.primary,
        //                 size: 20,
        //               ),
        //               const SizedBox(width: 8),
        //               Text(
        //                 l10n.recentSearch,
        //                 style: Theme.of(context).textTheme.titleMedium
        //                     ?.copyWith(
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //               ),
        //             ],
        //           ),
        //           if (_recentSearches.isNotEmpty)
        //             TextButton.icon(
        //               onPressed: () async {
        //                 await _recentSearchService.clearRecentSearches();
        //                 sl<RecentSearchBloc>().add(
        //                   const LoadRecentSearchEvent(),
        //                 );
        //               },
        //               icon: const Icon(Icons.clear_all, size: 16),
        //               label: Text(l10n.clear),
        //               style: TextButton.styleFrom(
        //                 padding: const EdgeInsets.symmetric(
        //                   horizontal: 8,
        //                   vertical: 4,
        //                 ),
        //                 minimumSize: Size.zero,
        //                 tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //               ),
        //             ),
        //         ],
        //       ),
        //       const SizedBox(height: 12),
        //       if (_recentSearches.isEmpty)
        //         Center(
        //           child: Text(
        //             l10n.noRecentSearchFound,
        //             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        //               color: Theme.of(context).colorScheme.onSurfaceVariant,
        //             ),
        //           ),
        //         )
        //       else
        //         Expanded(
        //           child: ListView.separated(
        //             itemCount: _recentSearches.length,
        //             separatorBuilder: (context, index) =>
        //                 const SizedBox(height: 8),
        //             itemBuilder: (context, index) {
        //               final search = _recentSearches[index];
        //               return Card(
        //                 elevation: 0.5,
        //                 shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(12),
        //                 ),
        //                 child: InkWell(
        //                   onTap: () {
        //                     _searchController.text = search.searchText;
        //                     _performSearch(search.searchText);
        //                   },
        //                   borderRadius: BorderRadius.circular(12),
        //                   child: Padding(
        //                     padding: const EdgeInsets.all(16),
        //                     child: Row(
        //                       children: [
        //                         Container(
        //                           padding: const EdgeInsets.all(8),
        //                           decoration: BoxDecoration(
        //                             color: search.isSuccess
        //                                 ? Colors.green.withOpacity(0.1)
        //                                 : Theme.of(
        //                                     context,
        //                                   ).colorScheme.error.withOpacity(0.1),
        //                             borderRadius: BorderRadius.circular(8),
        //                           ),
        //                           child: Icon(
        //                             search.isSuccess
        //                                 ? Icons.check_circle
        //                                 : Icons.cancel,
        //                             color: search.isSuccess
        //                                 ? Colors.green
        //                                 : Theme.of(context).colorScheme.error,
        //                             size: 20,
        //                           ),
        //                         ),
        //                         const SizedBox(width: 12),
        //                         Expanded(
        //                           child: Column(
        //                             crossAxisAlignment:
        //                                 CrossAxisAlignment.start,
        //                             children: [
        //                               Text(
        //                                 search.searchText,
        //                                 style: Theme.of(context)
        //                                     .textTheme
        //                                     .titleMedium
        //                                     ?.copyWith(
        //                                       fontWeight: FontWeight.w600,
        //                                     ),
        //                                 maxLines: 1,
        //                                 overflow: TextOverflow.ellipsis,
        //                               ),
        //                               const SizedBox(height: 4),
        //                               Text(
        //                                 search.isSuccess
        //                                     ? TimeAgoUtils.getTimeAgo(
        //                                         search.timestamp,
        //                                         context,
        //                                       )
        //                                     : l10n.notFound,
        //                                 style: Theme.of(context)
        //                                     .textTheme
        //                                     .bodySmall
        //                                     ?.copyWith(
        //                                       color: search.isSuccess
        //                                           ? Theme.of(
        //                                                   context,
        //                                                 )
        //                                                 .colorScheme
        //                                                 .onSurfaceVariant
        //                                           : Theme.of(
        //                                               context,
        //                                             ).colorScheme.error,
        //                                     ),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                         Icon(
        //                           Icons.search,
        //                           size: 16,
        //                           color: Theme.of(
        //                             context,
        //                           ).colorScheme.onSurfaceVariant,
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               );
        //             },
        //           ),
        //         ),
        //     ],
        //   ),
        // );
      },
    );
  }

  Widget _buildCompoundResult(Compound compound) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0.5,
          child: InkWell(
            onTap: () async {
              await context.push(
                AppRoutes.compoundDetails,
                extra: _searchController.text,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        _getStructureSmallImageUrl(compoundCid: compound.cid),
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const SizedBox(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: Icon(
                                Icons.image_outlined,
                                size: 72,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(
                              height: 100,
                              width: 100,
                              child: Center(
                                child: Icon(Icons.broken_image, size: 72),
                              ),
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _searchController.text,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        if (compound.cid > 0) ...[
                          const SizedBox(height: 4),
                          Text(
                            '#CID: ${compound.cid}',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildError(String message) {
    final l10n = context.l10n;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0.5,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.compoundNotFound,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 72,
                  child: Text(
                    _mapFailureToMessage(message),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getStructureSmallImageUrl({required int compoundCid}) {
    var imageUrl = Env.value.baseUrl;
    imageUrl += EndPoints.structureImage;
    imageUrl += '$compoundCid/PNG?image_size=small';
    return imageUrl;
  }

  String _mapFailureToMessage(String failure) {
    final failureMessage = failure.toLowerCase();
    final l10n = context.l10n;
    if (failureMessage.contains('not found') ||
        failureMessage.contains('404') ||
        failureMessage.contains('no cid found')) {
      return l10n.checkSpellingOrTryAnother;
    } else if (failureMessage.contains('network') ||
        failureMessage.contains('connection') ||
        failureMessage.contains('timeout')) {
      return l10n.netErrorTryAgain;
    } else if (failureMessage.contains('server') ||
        failureMessage.contains('500') ||
        failureMessage.contains('503')) {
      return l10n.serverErrorUnable;
    } else if (failureMessage.contains('bad response') ||
        failureMessage.contains('unexpected')) {
      return l10n.serverErrorUnable;
    } else {
      return l10n.serverErrorUnable;
    }
  }
}
