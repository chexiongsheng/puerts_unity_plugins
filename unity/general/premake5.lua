
solution "Puerts"
    configurations {
        "Debug", "Release"
    }

    location ("./" .. (_ACTION or ""))
    debugdir (".")
    debugargs {  }

    platforms { "Any CPU" }

configuration "Debug"
    symbols "On"
    defines { "_DEBUG", "DEBUG", "TRACE" }
configuration "Release"
    flags { "Optimize" }
configuration "vs*"
    defines { "" }

project "Puerts.Core"
language "C#"
kind "SharedLib"
framework "3.5"
targetdir "./Lib"

files
{
    "../Assets/Puerts/Src/*.cs",
}

defines
{
	"PUERTS_GENERAL",
}

links
{
    "System",
    "System.Core",
}


project "Puerts.Helloworld"
language "C#"
kind "ConsoleApp"
framework "4.0"
targetdir "./Bin"

files
{
    "./Src/Helloworld.cs",
}

defines
{
}

links
{
    "System",
    "System.Core",
    "Puerts.Core",
}

project "Puerts.UnitTest"
language "C#"
kind "SharedLib"
framework "4.0"
targetdir "./Bin"

dependson { "Puerts.Core"}

files
{
    "Src/UnitTest/*.cs",
}

defines
{
	
}

links
{
    "System",
    "System.Core",
    "Puerts.Core",
}
