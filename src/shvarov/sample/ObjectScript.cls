Class shvarov.sample.ObjectScript
{

ClassMethod Test() As %Status
{
    set a=42
    write "Hello World!",!
    write "This is IPM demo "_$classname(),!
    write "This is InterSystems IRIS with version ",$zv,!
    write "Current time is: "_$zdt($h,2)
    return a
}

ClassMethod GenDashboardForCSV(csv, classdata, cubename, clscube)
{

    set sc=$$$OK
    set sc=$zpm("install csvgen")
    set clsdata=$g(clsdata,"zpmdemo.data"_$P($H,",",2))
    set clscube=$g(clscube,"zpmdemo.cube"_$P($H,",",2))
    set cubename=$g(cubename,"DemoCube"_$P($H,",",2))
    set sc=##class(community.csvgen).GenerateFromURL(
    csv,
	,clsdata)


    if 'sc {
        write "Error: "_$system.Status.GetErrorText(sc),!
        quit sc

    }
    set sc=##class(%DeepSee.WizardUtils).%GenerateCubeDefinition(clsdata,cubename,clscube)
    if 'sc { do $system.Status.DisplayError(sc)
			quit sc}


  do $System.OBJ.Compile(clscube)
  set sc=##class(%DeepSee.Utils).%BuildCube(cubename)
  if 'sc { do $system.Status.DisplayError(sc)
			quit sc}

  set sc=$zpm("uninstall csvgen")
  set sc=$zpm("install analyzethis")
  do ##class(AnalyzeThis.Dashboard.AutoPivot).GenerateSampleDashboards(cubename)
  set sc=$zpm("uninstall analyzethis")
  q sc
}

}
