#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see http://aka.ms/containercompat 

#FROM microsoft/aspnet:4.7.2-windowsservercore-1803
#ARG source
#WORKDIR /inetpub/wwwroot
#COPY ${source:-obj/Docker/publish} .

#FROM microsoft/dotnet-framework-build:4.7.1 as build-env
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 as build-env

WORKDIR /app
COPY . /app
RUN nuget.exe restore SampleWebApplication.sln -SolutionDirectory ../ -Verbosity normal
RUN MSBuild.exe SampleWebApplication.sln /t:build /p:Configuration=Release /p:OutputPath=./out

FROM mcr.microsoft.com/dotnet/framework/sdk:4.8
WORKDIR /app
COPY --from=build-env app/out .

#ENTRYPOINT ["SampleWebApplication.exe"]
ENTRYPOINT ["dotnet", "run"]