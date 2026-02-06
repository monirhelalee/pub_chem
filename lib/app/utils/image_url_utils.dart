import 'package:pub_chem/app/config/env.dart';
import 'package:pub_chem/app/network_service/end_points.dart';

class ImageUrlUtils {
  ImageUrlUtils._();
  static String getMolecularStructureUrl({required int compoundCid}) {
    var imageUrl = Env.value.baseUrl;
    imageUrl += EndPoints.structureImage;
    imageUrl += '$compoundCid/PNG';
    return imageUrl;
  }

  static String getStructureSmallImageUrl({required int compoundCid}) {
    var imageUrl = Env.value.baseUrl;
    imageUrl += EndPoints.structureImage;
    imageUrl += '$compoundCid/PNG?image_size=small';
    return imageUrl;
  }
}
