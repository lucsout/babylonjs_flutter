import 'package:get/get.dart';
import 'package:sporty/controllers/login_controller.dart';

class Gallery {
  String? extraPageData;
  String? from;
  String? galleryDescription;
  String? galleryEmail;
  String? galleryFacebook;
  String? galleryInstagram;
  String? galleryTikTok;
  String? galleryWhatsapp;
  String? galleryIndirizzo;
  int? galleryPictures;
  List<String>? galleryUrls;
  String? gallerySito;
  String? galleryTelefono;
  bool? hasExtraPage;
  bool? hasQrcode;
  bool? hideLabelPosti;
  bool? isAttiva;
  bool? isFasciaOraria;
  bool? isPalinsestoEnabled;
  int? minutiTolleranza;
  String? palinsestoURL;
  String? to;

  Gallery(
      {this.extraPageData,
      this.from,
      this.galleryDescription,
      this.galleryEmail,
      this.galleryFacebook,
      this.galleryWhatsapp,
      this.galleryInstagram,
      this.galleryTikTok,
      this.galleryIndirizzo,
      this.galleryPictures,
      this.gallerySito,
      this.galleryTelefono,
      this.galleryUrls,
      this.hasExtraPage,
      this.hasQrcode,
      this.hideLabelPosti,
      this.isAttiva,
      this.isFasciaOraria,
      this.isPalinsestoEnabled,
      this.minutiTolleranza,
      this.palinsestoURL,
      this.to});

  Gallery.fromJson(Map<String, dynamic> json) {
    LoginController login = Get.find();

    extraPageData = json['ExtraPageData'];
    from = json['From'];
    galleryDescription = json['GalleryDescription'];
    galleryEmail = json['GalleryEmail'];
    galleryFacebook = json['GalleryFacebook'];
    galleryWhatsapp = json['GalleryWhatsapp'];
    galleryInstagram = json['GalleryInstagram'];
    galleryTikTok = json['GalleryTikTok'];
    galleryIndirizzo = json['GalleryIndirizzo'];
    galleryPictures = json['GalleryPictures'];

    galleryUrls = [];

    for (int i = 1; i <= galleryPictures!; i++) {
      galleryUrls!.add(
          'https://app.edilab.it/ImagesApp/SPORTY/${login.appID}/GALLERY_${i.toString()}.png');
    }

    gallerySito = json['GallerySito'];
    galleryTelefono = json['GalleryTelefono'];
    hasExtraPage = json['HasExtraPage'];
    hasQrcode = json['HasQrcode'];
    hideLabelPosti = json['HideLabelPosti'];
    isAttiva = json['IsAttiva'];
    isFasciaOraria = json['IsFasciaOraria'];
    isPalinsestoEnabled = json['IsPalinsestoEnabled'];
    minutiTolleranza = json['MinutiTolleranza'];
    palinsestoURL = json['PalinsestoURL'];
    to = json['To'];
  }
}
