import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pub_chem/app/config/service_locator.dart';
import 'package:pub_chem/app/router/app_routes.dart';
import 'package:pub_chem/app/utils/image_url_utils.dart';
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
import 'package:pub_chem/search/view/widgets/recent_search_list_tile_widget.dart';
import 'package:pub_chem/search/view/widgets/search_compound_loading_widget.dart';
import 'package:pub_chem/search/view/widgets/search_error_widget.dart';

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

  /// Saves search when state is already loaded/error on build (e.g. from cache).
  /// BlocListener misses these because it only fires on state transitions.
  void _saveSearchOnBuild(bool isSuccess) {
    final searchText = _currentSearchText;
    if (searchText == null) return;
    _currentSearchText = null;
    _saveSearch(searchText, isSuccess);
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
      padding: const .all(16),
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
              padding: .all(
                const .only(left: 16, right: 16),
              ),
              elevation: .all(0),
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
                    final text = _currentSearchText!;
                    _currentSearchText = null;
                    await _saveSearch(text, true);
                  }
                },
                error: (message) async {
                  if (_currentSearchText != null) {
                    final text = _currentSearchText!;
                    _currentSearchText = null;
                    await _saveSearch(text, false);
                  }
                },
              );
            },
            child: BlocBuilder<CompoundDetailsBloc, CompoundDetailsState>(
              bloc: _compoundDetailsBloc,
              builder: (context, state) {
                // When data loads from cache, state can be loaded before
                // BlocListener attaches. Save search on build for those cases.
                state.whenOrNull(
                  loaded: (_) {
                    if (_currentSearchText != null) {
                      _saveSearchOnBuild(true);
                    }
                  },
                  error: (_) {
                    if (_currentSearchText != null) {
                      _saveSearchOnBuild(false);
                    }
                  },
                );
                return state.when(
                  initial: SizedBox.new,
                  loading: () => const SearchCompoundLoadingWidget(),
                  loaded: _buildCompoundResult,
                  error: (message) => SearchErrorWidget(message: message),
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
              crossAxisAlignment: .start,
              children: [
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: .spaceBetween,
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
                                fontWeight: .bold,
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
                          padding: const .symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          minimumSize: .zero,
                          tapTargetSize: .shrinkWrap,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                if (value.isEmpty)
                  _recentSearchEmptyState()
                else
                  Expanded(
                    child: ListView.separated(
                      itemCount: value.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final search = value[index];
                        return RecentSearchListTileWidget(
                          onTap: () {
                            _searchController.text = search.searchText;
                            _performSearch(search.searchText);
                          },
                          search: search,
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          error: (message) => SearchErrorWidget(message: message),
        );
      },
    );
  }

  Widget _recentSearchEmptyState() {
    final l10n = context.l10n;
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Text(
            l10n.noRecentSearchFound,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompoundResult(Compound compound) {
    return Column(
      crossAxisAlignment: .start,
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
              padding: const .all(16),
              child: Row(
                children: [
                  Container(
                    padding: const .all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: .circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: .circular(8),
                      child: Image.network(
                        ImageUrlUtils.getStructureSmallImageUrl(
                          compoundCid: compound.cid,
                        ),
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
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          _searchController.text,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: .bold,
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
}
