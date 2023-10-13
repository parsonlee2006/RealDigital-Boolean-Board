#Map Pin R17 to the net wire sw
#external pin connections must be defined in a constraints file
set_property -dict { PACKAGE_PIN V2   IOSTANDARD LVCMOS33 } [get_ports { sw }];
set_property -dict { PACKAGE_PIN G1   IOSTANDARD LVCMOS33 } [get_ports { led }];