# Package-WebAPI.ps1
#
# Packages the NHibernate.Spatial Nugets. This script is useful for local development 
# so that you can compile the packages without waiting for TeamCity.
#
# This script can be run from the Powershell Command-Line or 
# the Nuget Package Manager console:
#
#	PM> .\Package-Nugets.ps1
#
# You can install the local packages in another project by using the Package Manager Console
# and specifying the -Source flag for your local package directory.
#
#	Example:
#		PM> Install-Package NHibernate.Spatial.PostGis -Version 1.0.0 -Source C:\Nugets
#
# Remeber to switch back to the TeamCity compiled package before you commit & push to github!
#

# Command line args
param([string]$Configuration="")

if (! $Configuration) { $Configuration = "Debug" }

# NuGet executable
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path 
$NugetPath = Join-Path $ScriptPath ".nuget/nuget.exe"

# Your local package source
$SourcePath = "C:\Nugets"

# Get 'er Done
Write-Host "Packaging nugets to $SourcePath ..."

Start-Process $NugetPath -Wait -WorkingDirectory "NHibernate.Spatial" -ArgumentList "pack", "NHibernate.Spatial.csproj", -"Build", "-Prop Configuration=$Configuration", "-OutputDirectory $SourcePath"

Start-Process $NugetPath -Wait -WorkingDirectory "NHibernate.Spatial.MsSql2008" -ArgumentList "pack", "NHibernate.Spatial.MsSql2008.csproj", "-Build", "-IncludeReferencedProjects","-Prop Configuration=$Configuration", "-OutputDirectory $SourcePath"
Start-Process $NugetPath -Wait -WorkingDirectory "NHibernate.Spatial.MsSqlSpatial" -ArgumentList "pack", "NHibernate.Spatial.MsSqlSpatial.csproj", "-Build", "-IncludeReferencedProjects", "-Prop Configuration=$Configuration", "-OutputDirectory $SourcePath"
Start-Process $NugetPath -Wait -WorkingDirectory "NHibernate.Spatial.MySQL" -ArgumentList "pack", "NHibernate.Spatial.MySQL.csproj", "-Build", "-IncludeReferencedProjects", "-Prop Configuration=$Configuration", "-OutputDirectory $SourcePath"
Start-Process $NugetPath -Wait -WorkingDirectory "NHibernate.Spatial.PostGis" -ArgumentList "pack", "NHibernate.Spatial.PostGis.csproj", "-Build","-IncludeReferencedProjects", "-Prop Configuration=$Configuration", "-OutputDirectory $SourcePath"
								   
Write-Host "Done."