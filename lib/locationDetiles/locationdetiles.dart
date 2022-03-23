import 'package:KurdTour/home_main/home_screen_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/location.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationDetileView extends StatefulWidget {
  const LocationDetileView({Key? key, required this.loc}) : super(key: key);
  final Location loc;
  @override
  State<LocationDetileView> createState() => _LocationDetileViewState();
}

class _LocationDetileViewState extends State<LocationDetileView> {
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    final marker = Marker(
      markerId: MarkerId(widget.loc.title.toString()),
      position:
          LatLng(widget.loc.loca!.toDouble(), widget.loc.locl!.toDouble()),
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: widget.loc.title,
      ),
    );
    setState(() {
      markers[MarkerId(widget.loc.title.toString())] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255)),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomeMainScreen()));
            },
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Location Detail",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.amber[500],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(left: 5, top: 5, right: 5),
                //height: 800,
                width: 350,
                color: Colors.grey[200],
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          widget.loc.image.toString(),
                          fit: BoxFit.cover,
                          height: 200,
                          width: 340,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            widget.loc.title.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          alignment: Alignment.center,
                          child: RatingBarIndicator(
                            rating: widget.loc.rating!.toDouble(),
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 25,
                            direction: Axis.horizontal,
                          ),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 5, left: 60),
                      child: Text(
                        widget.loc.locationname.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: const Text('Description',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Container(
                      width: 330,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(widget.loc.description.toString(),
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 12,
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Opining hours : ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.loc.openhourse.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: const Text(
                            "Visit Website",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          onTap: () => {launch(widget.loc.website!)},
                        ),
                        InkWell(
                          child: const Text(
                            "Call",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          onTap: () =>
                              {launch('tel:' + widget.loc.phone.toString())},
                        ),
                        InkWell(
                          child: const Text(
                            "Email",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          onTap: () => {launch('mailto:' + widget.loc.email!)},
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 340,
                      height: 215,
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(widget.loc.loca!.toDouble(),
                              widget.loc.locl!.toDouble()),
                          zoom: 16.0,
                        ),
                        markers: markers.values.toSet(),
                        myLocationButtonEnabled: true,
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
