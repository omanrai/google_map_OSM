import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import 'controller.dart';
import 'model.dart';

class TransportPage extends StatelessWidget {
  final TransportController transportController =
      Get.put(TransportController());

  TransportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Detail"),
      ),
      body: RefreshIndicator(
        onRefresh: () => transportController.onRefresh(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<TransportController>(builder: (controller) {
                if (controller.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.errorServerData.isNotEmpty) {
                  return Center(child: Text(controller.errorServerData));
                } else if (controller.vehicleModel.data == null) {
                  return Center(child: Text("No data available"));
                } else {
                  final Datum data = controller.vehicleModel.data![0];

                  return Container(
                    color: Colors.amber,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Number: ${data.number}"),
                        Text("GPS Status: ${data.gpsStatus}"),
                        Text("Last Located At: ${data.lastLocatedAt}"),
                        Text("Last Located At: ${data.lastLocation}"),
                        Text(
                            "Device Phone Number: ${data.device?.phoneNumber}"),
                        SizedBox(height: 10),
                        Text("Location"),
                        SizedBox(height: 10),
                        Text(
                            "Lat: ${data.additionalAttributes?.movementMetrics?.location?.lat ?? 'N/A'}"),
                        Text(
                            "Long: ${data.additionalAttributes?.movementMetrics?.location?.long ?? 'N/A'}"),
                        Text(
                            "Address: ${data.additionalAttributes?.movementMetrics?.location?.address ?? 'N/A'}"),
                        SizedBox(height: 10),
                        Text("Motion Info"),
                        SizedBox(height: 10),
                        Text(
                            "Motion Status: ${data.additionalAttributes?.movementMetrics?.motionStatus}"),
                        Text("Is Mobilized: ${data.isMobilized}"),
                        Text(
                            "bus speed: ${data.additionalAttributes?.movementMetrics?.speed?.unit}"),
                        Text(
                            "speed value: ${data.additionalAttributes?.movementMetrics?.speed?.value}"),
                      ],
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
