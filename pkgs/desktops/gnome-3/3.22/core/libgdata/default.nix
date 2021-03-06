{ stdenv, fetchurl, pkgconfig, intltool, libxml2, glib, json_glib
, gobjectIntrospection, liboauth, gnome3, p11_kit, openssl, uhttpmock }:

let
  majorVersion = "0.17";
in
stdenv.mkDerivation rec {
  name = "libgdata-${majorVersion}.6";

  src = fetchurl {
    url = "mirror://gnome/sources/libgdata/${majorVersion}/${name}.tar.xz";
    sha256 = "8b6a3ff1db23bd9e5ebbcc958b29b769a898f892eed4798222d562ba69df30b0";
  };

  NIX_CFLAGS_COMPILE = "-I${gnome3.libsoup.dev}/include/libsoup-gnome-2.4/ -I${gnome3.gcr}/include/gcr-3 -I${gnome3.gcr}/include/gck-1";

  buildInputs = with gnome3;
    [ pkgconfig libsoup intltool libxml2 glib gobjectIntrospection
      liboauth gcr gnome_online_accounts p11_kit openssl uhttpmock ];

  propagatedBuildInputs = [ json_glib ];

  meta = with stdenv.lib; {
    description = "GData API library";
    maintainers = with maintainers; [ raskin lethalman ];
    platforms = platforms.linux;
    license = licenses.lgpl21Plus;
  };

}
