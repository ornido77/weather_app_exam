import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getWeatherPhrase(String description) {
  switch (description.toLowerCase()) {
    case "clear sky":
      return "☀️ A perfect day to soak up some sun! Don't forget your shades. 😎";
    case "few clouds":
      return "🌤️ Some clouds are hanging around, but the sun is still shining through!";
    case "scattered clouds":
      return "⛅ The sky is playing hide and seek with the sun today.";
    case "broken clouds":
      return "🌥️ The clouds are trying to take over, but the sun won’t give up!";
    case "overcast clouds":
      return "☁️ A gloomy day, but hey, perfect for cozying up with coffee!";
    case "light rain":
      return "🌦️ Just a drizzle! A light jacket should do the trick.";
    case "moderate rain":
      return "🌧️ Don’t forget your umbrella—it's a proper rainy day!";
    case "heavy rain":
      return "⛈️ Stay indoors if you can, or bring your rain boots!";
    case "thunderstorm":
      return "⛈️ Thunder is rolling! Maybe it's a good time for a movie indoors.";
    case "snow":
      return "❄️ It's snowing! Time to build a snowman or enjoy some hot cocoa.";
    case "mist":
      return "🌫️ A little foggy out there. Drive safe and watch your step!";
    default:
      return "🌍 The weather is full of surprises today!";
  }
}

String getGreeting() {
  int hour = DateTime.now().hour;
  if (hour >= 5 && hour < 12) {
    return "Good Morning! ☀️";
  } else if (hour >= 12 && hour < 18) {
    return "Good Afternoon! 🌤️";
  } else {
    return "Good Evening! 🌙";
  }
}

String getFormattedDateTime() {
  final now = DateTime.now();
  final formattedDate = DateFormat('EEEE dd - hh:mma').format(now);
  return formattedDate;
}

String getCountryFlag(String countryCode) {
  return countryCode.toUpperCase().split('').map((letter) {
    return String.fromCharCode(0x1F1A5 + letter.codeUnitAt(0));
  }).join();
}

String getCountryName(String countryCode) {
  final Map<String, String> countryMap = {
    "AF": "Afghanistan",
    "AX": "Åland Islands",
    "AL": "Albania",
    "DZ": "Algeria",
    "AS": "American Samoa",
    "AD": "Andorra",
    "AO": "Angola",
    "AI": "Anguilla",
    "AQ": "Antarctica",
    "AG": "Antigua and Barbuda",
    "AR": "Argentina",
    "AM": "Armenia",
    "AW": "Aruba",
    "AU": "Australia",
    "AT": "Austria",
    "AZ": "Azerbaijan",
    "BS": "Bahamas",
    "BH": "Bahrain",
    "BD": "Bangladesh",
    "BB": "Barbados",
    "BY": "Belarus",
    "BE": "Belgium",
    "BZ": "Belize",
    "BJ": "Benin",
    "BM": "Bermuda",
    "BT": "Bhutan",
    "BO": "Bolivia",
    "BQ": "Bonaire, Sint Eustatius, and Saba",
    "BA": "Bosnia and Herzegovina",
    "BW": "Botswana",
    "BV": "Bouvet Island",
    "BR": "Brazil",
    "IO": "British Indian Ocean Territory",
    "BN": "Brunei",
    "BG": "Bulgaria",
    "BF": "Burkina Faso",
    "BI": "Burundi",
    "CV": "Cabo Verde",
    "KH": "Cambodia",
    "CM": "Cameroon",
    "CA": "Canada",
    "KY": "Cayman Islands",
    "CF": "Central African Republic",
    "TD": "Chad",
    "CL": "Chile",
    "CN": "China",
    "CX": "Christmas Island",
    "CC": "Cocos (Keeling) Islands",
    "CO": "Colombia",
    "KM": "Comoros",
    "CG": "Congo",
    "CD": "Congo (Democratic Republic)",
    "CK": "Cook Islands",
    "CR": "Costa Rica",
    "CI": "Côte d'Ivoire",
    "HR": "Croatia",
    "CU": "Cuba",
    "CW": "Curaçao",
    "CY": "Cyprus",
    "CZ": "Czech Republic",
    "DK": "Denmark",
    "DJ": "Djibouti",
    "DM": "Dominica",
    "DO": "Dominican Republic",
    "EC": "Ecuador",
    "EG": "Egypt",
    "SV": "El Salvador",
    "GQ": "Equatorial Guinea",
    "ER": "Eritrea",
    "EE": "Estonia",
    "SZ": "Eswatini",
    "ET": "Ethiopia",
    "FK": "Falkland Islands",
    "FO": "Faroe Islands",
    "FJ": "Fiji",
    "FI": "Finland",
    "FR": "France",
    "GF": "French Guiana",
    "PF": "French Polynesia",
    "GA": "Gabon",
    "GM": "Gambia",
    "GE": "Georgia",
    "DE": "Germany",
    "GH": "Ghana",
    "GI": "Gibraltar",
    "GR": "Greece",
    "GL": "Greenland",
    "GD": "Grenada",
    "GU": "Guam",
    "GT": "Guatemala",
    "GG": "Guernsey",
    "GN": "Guinea",
    "GW": "Guinea-Bissau",
    "GY": "Guyana",
    "HT": "Haiti",
    "HN": "Honduras",
    "HK": "Hong Kong",
    "HU": "Hungary",
    "IS": "Iceland",
    "IN": "India",
    "ID": "Indonesia",
    "IR": "Iran",
    "IQ": "Iraq",
    "IE": "Ireland",
    "IM": "Isle of Man",
    "IL": "Israel",
    "IT": "Italy",
    "JM": "Jamaica",
    "JP": "Japan",
    "JE": "Jersey",
    "JO": "Jordan",
    "KZ": "Kazakhstan",
    "KE": "Kenya",
    "KI": "Kiribati",
    "KW": "Kuwait",
    "KG": "Kyrgyzstan",
    "LA": "Laos",
    "LV": "Latvia",
    "LB": "Lebanon",
    "LS": "Lesotho",
    "LR": "Liberia",
    "LY": "Libya",
    "LI": "Liechtenstein",
    "LT": "Lithuania",
    "LU": "Luxembourg",
    "MO": "Macau",
    "MG": "Madagascar",
    "MW": "Malawi",
    "MY": "Malaysia",
    "MV": "Maldives",
    "ML": "Mali",
    "MT": "Malta",
    "MH": "Marshall Islands",
    "MQ": "Martinique",
    "MR": "Mauritania",
    "MU": "Mauritius",
    "MX": "Mexico",
    "FM": "Micronesia",
    "MD": "Moldova",
    "MC": "Monaco",
    "MN": "Mongolia",
    "ME": "Montenegro",
    "MA": "Morocco",
    "MZ": "Mozambique",
    "MM": "Myanmar",
    "NA": "Namibia",
    "NR": "Nauru",
    "NP": "Nepal",
    "NL": "Netherlands",
    "NZ": "New Zealand",
    "NI": "Nicaragua",
    "NE": "Niger",
    "NG": "Nigeria",
    "KP": "North Korea",
    "NO": "Norway",
    "OM": "Oman",
    "PK": "Pakistan",
    "PW": "Palau",
    "PA": "Panama",
    "PG": "Papua New Guinea",
    "PY": "Paraguay",
    "PE": "Peru",
    "PH": "Philippines",
    "PL": "Poland",
    "PT": "Portugal",
    "PR": "Puerto Rico",
    "QA": "Qatar",
    "RO": "Romania",
    "RU": "Russia",
    "RW": "Rwanda",
    "SA": "Saudi Arabia",
    "SN": "Senegal",
    "RS": "Serbia",
    "SG": "Singapore",
    "SK": "Slovakia",
    "SI": "Slovenia",
    "ZA": "South Africa",
    "KR": "South Korea",
    "ES": "Spain",
    "LK": "Sri Lanka",
    "SE": "Sweden",
    "CH": "Switzerland",
    "TW": "Taiwan",
    "TZ": "Tanzania",
    "TH": "Thailand",
    "TR": "Turkey",
    "UG": "Uganda",
    "UA": "Ukraine",
    "AE": "United Arab Emirates",
    "GB": "United Kingdom",
    "US": "United States",
    "UY": "Uruguay",
    "UZ": "Uzbekistan",
    "VE": "Venezuela",
    "VN": "Vietnam",
    "YE": "Yemen",
    "ZM": "Zambia",
    "ZW": "Zimbabwe",
  };

  return countryMap[countryCode.toUpperCase()] ?? "Unknown Country";
}

void showDataDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(content, style: const TextStyle(fontSize: 14)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
            },
            child: const Text("Close"),
          ),
        ],
      );
    },
  );
}
