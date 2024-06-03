


// searchJobLocation(context) async {
//   Prediction? p = await PlacesAutocomplete.

//   show(

//       insetPadding: const EdgeInsets.symmetric(vertical: 200),
//       hint: 'search location',
//       context: context,
//       resultTextStyle: kSubHeading17GreyTextStyle,
//       textDecoration: InputDecoration(
//           constraints: const BoxConstraints(minHeight: 30, minWidth: 40),
//           filled: true,

//           fillColor: kTextFieldColor,
//           border: InputBorder.none,
//           enabledBorder: const OutlineInputBorder(
//               gapPadding: 0,
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.all(Radius.circular(15))),
//           disabledBorder: InputBorder.none,
//           contentPadding: const EdgeInsets.only(left: 20),
//           focusedBorder: const OutlineInputBorder(
//               gapPadding: 0,
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.all(Radius.circular(15))),
//           errorBorder: InputBorder.none,
//           floatingLabelBehavior: FloatingLabelBehavior.auto,
//           hintText: "Search",
//           hintStyle: kBelowNormal12GreyTextStyle.copyWith(
//               fontFamily: 'Poppins', color: kDisableColor),
//           labelStyle: kBelowNormal12GreyTextStyle,
//           suffixIcon: Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: Container(
//               width: 5,
//               alignment: Alignment.centerRight,
//               child: const Icon(Icons.search, size: 20, color: kDisableColor),
//             ),
//           )),
//       apiKey: BaseHelper.kGoogleApiKey,
//       mode: Mode.fullscreen,
//       language: "pk",
//       logo: const SizedBox(),
//       components: [Component(Component.country, "pk")]);

//   String placeid = p?.placeId ?? "0";


//   if (placeid == '0') return;

//   return placeid;
// }
