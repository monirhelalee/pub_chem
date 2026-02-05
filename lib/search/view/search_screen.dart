import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pub_chem/app/config/env.dart';
import 'package:pub_chem/app/network_service/end_points.dart';
import 'package:pub_chem/app/router/app_routes.dart';
import 'package:pub_chem/compound_details/domain/entities/compound.dart';
import 'package:pub_chem/compound_details/view/bloc/compound_details_bloc.dart';
import 'package:pub_chem/compound_details/view/bloc/compound_details_event.dart';
import 'package:pub_chem/compound_details/view/bloc/compound_details_state.dart';
import 'package:pub_chem/l10n/l10n.dart';
import 'package:pub_chem/search/view/widgets/search_compound_loading_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
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
          SearchBar(
            controller: _searchController,
            trailing: [
              InkWell(
                onTap: () {
                  if (_searchController.text.isNotEmpty) {
                    context.read<CompoundDetailsBloc>().add(
                      LoadCompoundDetails(compoundName: _searchController.text),
                    );
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
                context.read<CompoundDetailsBloc>().add(
                  LoadCompoundDetails(compoundName: value),
                );
              }
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<CompoundDetailsBloc, CompoundDetailsState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(
                    child: Text(
                      'Enter a compound name to search',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  loading: () => const SearchCompoundLoadingWidget(),
                  loaded: _buildCompoundResult,
                  error: _buildError,
                );
              },
            ),
          ),
        ],
      ),
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
                        _getStructureSmallImageUrl(compoundCid: compound.cid),
                        height: 100,
                        width: 100,
                        fit: .fill,
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

  Widget _buildError(String message) {
    final l10n = context.l10n;
    return Row(
      crossAxisAlignment: .start,
      children: [
        Card(
          elevation: 0.5,
          child: Padding(
            padding: const .all(16),
            child: Column(
              mainAxisAlignment: .center,
              mainAxisSize: .min,
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
                    fontWeight: .bold,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 72,
                  child: Text(
                    _mapFailureToMessage(message),
                    textAlign: .center,
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

  String _mapFailureToMessage(failure) {
    final failureMessage = failure.toString().toLowerCase();
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
