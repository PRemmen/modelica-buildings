within Buildings.ThermalZones.Detailed.Examples;
model ElectroChromicWindow
  "Model that illustrates the use of electrochromic windows"
  extends Modelica.Icons.Example;
  package MediumA = Buildings.Media.Air(T_default=T_start) "Medium model";

  constant Modelica.SIunits.Temperature T_start=273.15 + 20 "Initial value";

  parameter Integer nConExtWin=1 "Number of constructions with a window";
  parameter Integer nConExt=0 "Number of constructions without a window";
  parameter Integer nConBou=5
    "Number of surface that are connected to constructions that are modeled inside the room";
  parameter Integer nSurBou=0
    "Number of surface that are connected to the room air volume";
  parameter Integer nConPar=0 "Number of surface that are partitions";

  MixedAir roo(
    redeclare package Medium = MediumA,
    nConExt=nConExt,
    nConExtWin=nConExtWin,
    nConPar=nConPar,
    nConBou=nConBou,
    nSurBou=nSurBou,
    linearizeRadiation=false,
    T_start=T_start,
    datConExtWin(
      layers={matExtWal},
      each A=10.22,
      glaSys={glaSys},
      each hWin=3.13,
      each wWin=2.782751,
      each fFra=0.000001,
      each til=Buildings.Types.Tilt.Wall,
      azi={Buildings.Types.Azimuth.S}),
    datConBou(
      layers={matFlo,matCeil,matEWWal,matNWal,matEWWal},
      A={13.94,13.94,15.33,10.22,15.33},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Wall,
          Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),
    AFlo=13.94,
    hRoo=3.37,
    intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Temperature,
    extConMod=Buildings.HeatTransfer.Types.ExteriorConvection.TemperatureWind,
    each conBou(opa(T(each start = T_start))),
    nPorts=2,
    lat=0.65484753534827,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial) "Room model"
    annotation (Placement(transformation(extent={{62,-16},{102,24}})));
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(
    relHum=0,
    TDewPoi(displayUnit="K"),
    filNam=
        "modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos",
    pAtmSou=Buildings.BoundaryConditions.Types.DataSource.File,
    calTSky=Buildings.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation)
    annotation (Placement(transformation(extent={{140,104},{160,124}})));

  Modelica.Blocks.Sources.Constant uSha(k=0)
    "Control signal for the shading device"
    annotation (Placement(transformation(extent={{-44,54},{-24,74}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=max(1, nConExtWin))
    annotation (Placement(transformation(extent={{-4,54},{16,74}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matExtWal(
    nLay=3,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.6,
    absSol_b=0.6,
    material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.000701,
        k=45.345,
        c=502.416,
        d=7833.028),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.0127,
        k=0.12,
        c=1210,
        d=540),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.133,
        k=0.047,
        c=1006,
        d=93.84)}) "71T: South Wall"
    annotation (Placement(transformation(extent={{-20,106},{0,126}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matCeil(
    nLay=3,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.6,
    absSol_b=0.6,
    material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.009525,
        k=0.12,
        c=1210,
        d=540),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.133,
        k=0.047,
        c=1006,
        d=93.84),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.015875,
        k=0.17,
        c=1090,
        d=800)}) "71T: Ceiling"
    annotation (Placement(transformation(extent={{36,106},{56,126}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matFlo(
    final nLay=4,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.6,
    absSol_b=0.6,
    material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=5.28,
        k=1,
        c=0,
        d=0),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.01905,
        k=0.15,
        c=1630,
        d=608),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.01905,
        k=0.12,
        c=1210,
        d=540),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.22,
        k=1,
        c=0,
        d=0)}) "71T: Floor"
    annotation (Placement(transformation(extent={{60,106},{80,126}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matEWWal(
    final nLay=2,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.6,
    absSol_b=0.6,
    material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.133,
        k=0.047,
        c=1006,
        d=93.84),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.015875,
        k=0.17,
        c=1090,
        d=800)}) "71T: East West Wall"
    annotation (Placement(transformation(extent={{10,106},{30,126}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matNWal(
    final nLay=4,
    absIR_a=0.9,
    absIR_b=0.9,
    absSol_a=0.6,
    absSol_b=0.6,
    material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.015875,
        k=0.17,
        c=1090,
        d=800),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.009525,
        k=0.12,
        c=1210,
        d=540),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.133,
        k=0.047,
        c=1006,
        d=93.84),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.015875,
        k=0.17,
        c=1090,
        d=800)}) "71T: North Wall"
    annotation (Placement(transformation(extent={{86,106},{106,126}})));

  parameter HeatTransfer.Data.GlazingSystems.DoubleElectrochromicAir13Clear glaSys(
    UFra=2,
    haveInteriorShade=false,
    haveExteriorShade=false) "Data record for the glazing system"
    annotation (Placement(transformation(extent={{-48,106},{-28,126}})));
  BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{138,8},{162,32}}),  iconTransformation(extent={
            {-116,36},{-96,56}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1
    annotation (Placement(transformation(extent={{-56,-26},{-36,-6}})));
  Modelica.Blocks.Sources.Constant qRadGai_flow(k=0) "Radiative heat gain"
    annotation (Placement(transformation(extent={{-94,16},{-74,36}})));
  Modelica.Blocks.Sources.Constant qConGai_flow(k=0) "Convective heat gain"
    annotation (Placement(transformation(extent={{-96,-26},{-76,-6}})));
  Modelica.Blocks.Sources.Constant qLatGai_flow(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-96,-66},{-76,-46}})));

  Controls.ElectrochromicWindow conWin "Controller for windows"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir
    "Room air temperature"
    annotation (Placement(transformation(extent={{110,-6},{130,14}})));
  Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumA,
    m_flow=-47*6/3600*1.2,
    T=293.15,
    nPorts=1) "Boundary condition"
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  Fluid.Sources.Outside freshAir(redeclare package Medium = MediumA, nPorts=1)
    "Boundary condition"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Fluid.FixedResistances.PressureDrop duc(
    redeclare package Medium = MediumA,
    allowFlowReversal=false,
    linearized=true,
    from_dp=true,
    dp_nominal=100,
    m_flow_nominal=47*6/3600*1.2)
    "Duct resistance (to decouple room and outside pressure)"
    annotation (Placement(transformation(extent={{34,-46},{46,-34}})));
equation

  connect(uSha.y, replicator.u) annotation (Line(
      points={{-23,64},{-6,64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(roo.uSha, replicator.y) annotation (Line(
      points={{60.4,22},{40,22},{40,64},{17,64}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(weaBus, roo.weaBus) annotation (Line(
      points={{150,20},{136,20},{136,21.9},{99.9,21.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus, weaDat1.weaBus) annotation (Line(
      points={{150,20},{150,20},{196,20},{196,114},{160,114}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(qRadGai_flow.y, multiplex3_1.u1[1]) annotation (Line(points={{-73,26},
          {-68,26},{-68,-9},{-58,-9}},          color={0,0,127}));
  connect(qConGai_flow.y, multiplex3_1.u2[1])
    annotation (Line(points={{-75,-16},{-66.5,-16},{-58,-16}},
                                                            color={0,0,127}));
  connect(qLatGai_flow.y, multiplex3_1.u3[1]) annotation (Line(points={{-75,-56},
          {-72,-56},{-72,-26},{-58,-26},{-58,-23}},
                                                 color={0,0,127}));
  connect(multiplex3_1.y, roo.qGai_flow) annotation (Line(points={{-35,-16},{
          -35,-16},{38,-16},{38,12},{60.4,12}},
                                        color={0,0,127}));
  connect(roo.heaPorAir, TRooAir.port)
    annotation (Line(points={{81,4},{94,4},{108,4},{110,4}}, color={191,0,0}));
  connect(TRooAir.T, conWin.T) annotation (Line(points={{130,4},{134,4},{134,30},
          {-10,30},{-10,14},{-1.5,14}}, color={0,0,127}));
  connect(conWin.H, weaBus.HGloHor) annotation (Line(points={{-1.5,6},{-12,6},{-12,
          34},{150,34},{150,20}}, color={0,0,127}));
  connect(conWin.y, roo.uWin[1]) annotation (Line(points={{21,10},{30,10},{30,17},
          {60.4,17}}, color={0,0,127}));
  connect(freshAir.weaBus, weaBus) annotation (Line(
      points={{0,-39.8},{-8,-39.8},{-8,-40},{-20,-40},{-20,-92},{150,-92},{150,20}},
      color={255,204,51},
      thickness=0.5));

  connect(freshAir.ports[1], duc.port_a)
    annotation (Line(points={{20,-40},{34,-40}}, color={0,127,255}));
  connect(boundary.ports[1], roo.ports[1]) annotation (Line(points={{20,-70},{44,
          -70},{62,-70},{62,-8},{67,-8}}, color={0,127,255}));
  connect(duc.port_b, roo.ports[2]) annotation (Line(points={{46,-40},{58,-40},{
          58,-4},{67,-4}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{220,
            160}})),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/Detailed/Examples/ElectroChromicWindow.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model illustrates the use of an electrochromic window.
It uses a model of the test cell 71T, room B at LBNL,
and controls the window state based on room air temperature and solar irradiation.
</p>
</html>", revisions="<html>
<ul>
<li>
November 21, 2016, by Michael Wetter:<br/>
Removed unused block <code>Infiltration</code> which also had an error due to a wrong instance name.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/582\">#582</a>.
</li>
<li>
October 2, 2015, by Michael Wetter:<br/>
First implementation, based on
<a href=\"modelica://Buildings.ThermalZones.Detailed.Validation.LBNL_71T.RoomB.ElectroChromicWindow\">
Buildings.ThermalZones.Detailed.Validation.LBNL_71T.RoomB.ElectroChromicWindow</a>.
</li>
</ul>
</html>"),
    experiment(StopTime=604800));
end ElectroChromicWindow;
