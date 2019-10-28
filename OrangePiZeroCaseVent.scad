$fn=100;

r_ecke=3;
h_innen=14;
l_innen=56; //55.5;
b_innen=51.7; //51.2;
wand=1.2;

gehaeusehalter();
translate([5,l_innen+2*wand,0]) luefterhalter();
//luefterplatte();

module gehaeusehalter()
{
    difference()
    {
        //Aussenhülle
        hull()
        {
            translate([r_ecke, r_ecke, 0]) cylinder(h=h_innen+wand, r=r_ecke);
            translate([b_innen+2*wand-r_ecke, r_ecke, 0]) cylinder(h=h_innen+wand, r=r_ecke);
            translate([r_ecke, l_innen+2*wand-r_ecke, 0]) cylinder(h=h_innen+wand, r=r_ecke);
            translate([b_innen+2*wand-r_ecke, l_innen+2*wand-r_ecke, 0]) cylinder(h=h_innen+wand, r=r_ecke);
        }
        //Innenausschnitt
        translate([wand, wand, 0])
            hull()
            {
                translate([r_ecke, r_ecke, 0]) cylinder(h=h_innen, r=r_ecke);
                translate([b_innen-r_ecke, r_ecke, 0]) cylinder(h=h_innen, r=r_ecke);
                translate([r_ecke, l_innen-r_ecke, 0]) cylinder(h=h_innen, r=r_ecke);
                translate([b_innen-r_ecke, l_innen-r_ecke, 0]) cylinder(h=h_innen, r=r_ecke);
            }
        //Deckelausschnitt
        translate([wand+3, wand+3, h_innen])
            hull()
            {
                translate([r_ecke, r_ecke, 0]) cylinder(h=wand, r=r_ecke);
                translate([b_innen-r_ecke-6, r_ecke, 0]) cylinder(h=wand, r=r_ecke);
                translate([r_ecke, l_innen-r_ecke-6, 0]) cylinder(h=wand, r=r_ecke);
                translate([b_innen-r_ecke-6, l_innen-r_ecke-6, 0]) cylinder(h=wand, r=r_ecke);
            }
        //vorderer Ausschnitt für Luftauslass und USB
        translate([wand+5, 0, 0])cube([b_innen-2*5, wand, h_innen]);
        //hinter Ausschnitt für Lufteinlass
        translate([wand+5, l_innen+wand, wand])cube([b_innen-2*5, wand, h_innen-wand]);
    }
}

module luefterhalter(b=b_innen-2*5, h=h_innen-wand)
{
    difference()
    {
        //Aussenhülle
        hull()
        {
            cube([b+2*wand,wand,h+2*wand]);
            translate([(b+2*wand-40)/2, 20, 0]) rotate([20,0,0]) cube([40,wand,40]);
        }
        //Innenausschnitt
        hull()
        {
            translate([wand, 0, wand])cube([b,wand,h]);
            translate([(b+2*wand-40)/2+wand, 20, wand]) rotate([20,0,0]) cube([40-2*wand,wand,40-2*wand]);
        }
    }
    translate([(b+2*wand-40)/2, 20, 0]) rotate([20,0,0]) luefterplatte();
}

module luefterplatte()
{
    translate([0,2*wand,0])
    rotate([90,0,0])
    difference()
    {
        cube([40,40,2*wand]);
        //Lüfterloch
        translate([20,20,0]) cylinder(h=2*wand, d=40-2*wand);
        //Schraubenlöcher
        translate([4,4,0]) cylinder(h=2*wand, d=1.5);
        translate([36,4,0]) cylinder(h=2*wand, d=1.5);
        translate([4,36,0]) cylinder(h=2*wand, d=1.5);
        translate([36,36,0]) cylinder(h=2*wand, d=1.5);
    }
   
}
