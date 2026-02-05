import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_chem/app/config/env.dart';
import 'package:pub_chem/app/network_service/end_points.dart';
import 'package:pub_chem/compound_details/domain/entities/compound.dart';
import 'package:pub_chem/compound_details/view/bloc/compound_details_bloc.dart';
import 'package:pub_chem/compound_details/view/bloc/compound_details_event.dart';
import 'package:pub_chem/compound_details/view/bloc/compound_details_state.dart';
import 'package:pub_chem/compound_details/view/widgets/compound_details_loading_widget.dart';

class CompoundDetailsScreen extends StatefulWidget {
  const CompoundDetailsScreen({
    required this.compoundName,
    super.key,
  });

  final String compoundName;

  @override
  State<CompoundDetailsScreen> createState() => _CompoundDetailsScreenState();
}

class _CompoundDetailsScreenState extends State<CompoundDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CompoundDetailsBloc>().add(
      LoadCompoundDetails(compoundName: widget.compoundName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compound Details'),
      ),
      body: BlocBuilder<CompoundDetailsBloc, CompoundDetailsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const CompoundDetailsLoadingWidget(),
            loaded: _buildCompoundDetails,
            error: _buildError,
          );
        },
      ),
    );
  }

  Widget _buildCompoundDetails(Compound compound) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: .5,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.science_outlined,
                      size: 40,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.compoundName,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        if (compound.cid > 0) ...[
                          const SizedBox(height: 4),
                          Text(
                            'CID: ${compound.cid}',
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
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (compound.name.isNotEmpty)
            _buildInfoCard(
              icon: Icons.drive_file_rename_outline_outlined,
              title: 'IUPAC Name',
              content: compound.name,
            ),
          const SizedBox(height: 12),

          // Molecular Formula Card
          if (compound.molecularFormula.isNotEmpty)
            _buildInfoCard(
              icon: Icons.functions,
              title: 'Molecular Formula',
              content: compound.molecularFormula,
            ),

          // Molecular Weight Card
          if (compound.molecularWeight > 0) ...[
            const SizedBox(height: 12),
            _buildInfoCard(
              icon: Icons.scale,
              title: 'Molecular Weight',
              content: '${compound.molecularWeight.toStringAsFixed(2)} g/mol',
            ),
          ],

          // SMILES Card
          if (compound.smiles.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildInfoCard(
              icon: Icons.code,
              title: 'SMILES Notation',
              content: compound.smiles,
            ),
          ],

          const SizedBox(height: 12),
          _buildImageCard(
            icon: Icons.bubble_chart_outlined,
            title: 'Molecular Structure',
            cid: compound.cid,
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      elevation: .5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              content,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard({
    required IconData icon,
    required String title,
    required int cid,
  }) {
    return Card(
      elevation: .5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                _getMolecularStructureUrl(compoundCid: cid),
                width: double.infinity,
                height: 250,
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    height: 250,
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 48,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  height: 250,
                  child: Center(child: Icon(Icons.broken_image, size: 48)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error Loading Compound',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please try again!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                context.read<CompoundDetailsBloc>().add(
                  LoadCompoundDetails(compoundName: widget.compoundName),
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  String _getMolecularStructureUrl({required int compoundCid}) {
    var imageUrl = Env.value.baseUrl;
    imageUrl += EndPoints.structureImage;
    imageUrl += '$compoundCid/PNG';
    print(imageUrl);
    return imageUrl;
  }
}
