within Buildings.Fluid.HeatPumps.Calibration;
model ScrollWaterToWater
  "Calibration model for scroll water to water heat pump"
  extends Modelica.Icons.Example;
  extends Buildings.Fluid.HeatPumps.Calibration.BaseClasses.PartialWaterToWater(
    redeclare package Medium1 = Buildings.Media.Water,
    redeclare package Medium2 = Buildings.Media.Water,
    redeclare Buildings.Fluid.HeatPumps.ScrollWaterToWater heaPum(
      datHeaPum(
        etaEle=etaEle,
        PLos=PLos,
        dTSup=dTSup,
        UACon=UACon,
        UAEva=UAEva,
        volRat=volRat,
        V_flow_nominal=V_flow_nominal,
        leaCoe=leaCoe)),
    calDat(tableName="ManufacturerData",
           fileName=Modelica.Utilities.Files.loadResource(
          "modelica://Buildings/Resources/src/fluid/heatpumps/calibration/manufacturerData.txt")),
    UACon = 12000.0,
    UAEva = 12000.0,
    m1_flow_nominal=1.42,
    m2_flow_nominal=1.42);

  parameter Real volRat(min = 1.0, unit = "1") = 2.0
    "Built-in volume ratio";

  parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal(min = 0) = 0.009
    "Refrigerant volume flow rate at suction";

  parameter Modelica.SIunits.MassFlowRate leaCoe(min = 0) = 0.03
    "Leakage coefficient";

  parameter Modelica.SIunits.Efficiency etaEle = 0.696
    "Electro-mechanical efficiency of the compressor";

  parameter Modelica.SIunits.Power PLos(min = 0) = 500.0
    "Constant part of the compressor power losses";

  parameter Modelica.SIunits.TemperatureDifference dTSup(min = 0) = 10.0
    "Superheating at compressor suction";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},
            {100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{100,100}}),
      graphics={Text(extent={{-88,92},{-64,90}},
        lineColor={28,108,200})}),
    preferredView="info",
    __Dymola_Commands(file= "modelica://Buildings/Resources/Scripts/Dymola/Fluid/HeatPumps/Calibration/ScrollWaterToWater.mos"
        "Simulate and plot"),
    experiment(StopTime=142),
Documentation(info="<HTML>
<p>
Calibration model for the calibration of models for water to water heat pump
with scroll compressor.
</p>
<p>
Source and load temperatures and flow rates are read from an external time
table.
</p>
<p>
This model is called from the Python code that computes heat pump model
parameters from the performance data.
Heat pump model parameters are obtained through an optimization procedure that
minimizes the difference between the modeled and tabulated (from the
manufacturers) capacity and power input of the heat pump.
</p>
<p>
The optimization is done using a Python implementation of the heat pump model,
found in Buildings/Resources/src/fluid/heatpumps/calibration/.
Heat pump model parameters are verified using this modelica model after their
evaluation by the Python code.
</p>
<p>
Documentation for the Python code can be accessed
<a href=\"modelica://Buildings/Resources/src/fluid/heatpumps/calibration/doc/build/html/index.html\">
here</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
October 31, 2016, by Massimo Cimmino:<br/>
First implementation.
</li>
</ul>
</html>"));
end ScrollWaterToWater;
