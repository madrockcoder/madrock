import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/residential_address/enter_address_page.dart';
import 'package:geniuspay/app/KYC/view_models.dart/address_view_model.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/services/remote_config_service.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:ionicons/ionicons.dart';
import 'package:location/location.dart' as loc;

class PickAddressPage extends StatefulWidget {
  const PickAddressPage({Key? key}) : super(key: key);
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const PickAddressPage(),
      ),
    );
  }

  @override
  State<PickAddressPage> createState() => _PickAddressPageState();
}

class _PickAddressPageState extends State<PickAddressPage> {
  String? googleApikey = RemoteConfigService.getRemoteData.googleMapKey;
  //GoogleMapController? mapController;
  //contrller for Google map
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(27.6602292, 85.308027);
  Placemark? selectedAddress;
  late GoogleMapsPlaces _places;
  @override
  void initState() {
    getCurrentLocation();
    _places = GoogleMapsPlaces(apiKey: googleApikey);
    super.initState();
  }

  getCurrentLocation() async {
    final lat = (await loc.Location().getLocation()).latitude;
    final long = (await loc.Location().getLocation()).longitude;
    if (lat != null && long != null) {
      var addresses = await placemarkFromCoordinates(lat, long);
      setState(() {
        startLocation = LatLng(lat, long);
        selectedAddress = addresses.first;
        _loading = false;
      });
    }
  }

  final model = AddressViewModel();
  bool _loading = true;
  Future<void> _handlePressButton() async {
    if (!_loading) {
      //  final Suggestion result = await showSearch(
      //           context: context,
      //           delegate: AddressSearch(sessionToken),
      //         );
      if (model.country == null) {
        await model.searchCountry(context);
      }

      if (!mounted) return;
      Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: googleApikey!,
        onError: (response) {},
        mode: Mode.overlay,
        strictbounds: false,
        language: "en",
        /*     components: [
          Component(Component.country, "us"),
          Component(Component.country, "ca"),
          Component(Component.country, "in"),
          Component(Component.country, "gh"),
          if (model.country != null) Component(Component.country, model.country!.iso2.toLowerCase()),
        ],*/
      );
      if (p != null) {
        PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);
        final lat = detail.result.geometry!.location.lat;
        final lng = detail.result.geometry!.location.lng;
        var tempAddress = await placemarkFromCoordinates(lat, lng);
        setState(() {
          selectedAddress = tempAddress.first;
        });
        animateToAddress(lat, lng);
        // mapController?.animateCamera(
        //   CameraUpdate.newCameraPosition(
        //     CameraPosition(
        //         target: LatLng(lat, lng), bearing: 192, tilt: 0, zoom: 20),
        //   ),
        // );
      }
    }
  }

  animateToAddress(double lat, double lng) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, lng), bearing: 192, tilt: 0, zoom: 20),
    ));
  }

  //method called when map is created
  void _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
    // setState(() {
    //   mapController = controller;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColor.kAccentColor2,
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: _handlePressButton,
            child: Row(children: [
              const Gap(10),
              const Icon(
                Icons.search,
                size: 15,
              ),
              const Gap(20),
              Text(
                'Search',
                style: textTheme.bodyMedium,
              ),
            ]),
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Stack(children: [
              GoogleMap(
                //Map widget from google_maps_flutter package
                zoomGesturesEnabled: true, //enable Zoom in, out on map
                initialCameraPosition: CameraPosition(
                  //innital position in map
                  target: startLocation, //initial position
                  zoom: 15.0, //initial zoom level
                ),
                mapType: MapType.normal, //map type
                onMapCreated: _onMapCreated,
                onCameraMove: (CameraPosition cameraPosition) {
                  setState(() {
                    cameraPosition = cameraPosition; //when map is dragging
                  });
                },
                onCameraIdle: () async {
                  // when map drag stops
                  List<Placemark> placemarks =
                      await placemarkFromCoordinates(cameraPosition!.target.latitude, cameraPosition!.target.longitude);
                  setState(() {
                    selectedAddress = placemarks.first;
                  });
                },
              ),
              const Center(
                  //picker image on google map
                  child: Icon(
                Icons.location_on,
                size: 52,
              )),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Gap(20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColor.kAccentColor2,
                            child: Center(
                              child: Icon(
                                Ionicons.home,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Gap(10),
                          if (selectedAddress != null)
                            Expanded(
                              child: Text(
                                  '${selectedAddress!.name} ${selectedAddress?.postalCode} ${selectedAddress!.locality} ${selectedAddress!.country}'),
                            ),
                        ],
                      ),
                      const Gap(35),
                      ContinueButton(
                        context: context,
                        color: AppColor.kGoldColor2,
                        text: 'PICK ADDRESS',
                        onPressed: selectedAddress == null
                            ? null
                            : () {
                                EnterAddressPage.show(context, address: selectedAddress);
                              },
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              )
            ]),
    );
  }
}
