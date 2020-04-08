#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see http://aka.ms/containercompat 

#FROM microsoft/aspnet:4.7.2-windowsservercore-1803
#ARG source
#WORKDIR /inetpub/wwwroot
#COPY ${source:-obj/Docker/publish} .
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY SampleWebApplication/*.csproj ./SampleWebApplication/

RUN dotnet restore

# copy everything else and build app
COPY . .
WORKDIR /app/SampleWebApplication
RUN dotnet build

#FROM build AS testrunner
#WORKDIR /app/tests
#ENTRYPOINT ["dotnet", "test", "--logger:trx"]

#FROM build AS test
#WORKDIR /app/tests
#RUN dotnet test

FROM build AS publish
WORKDIR /app/SampleWebApplication
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/framework/runtime:4.8 AS runtime
WORKDIR /app
COPY --from=publish /app/SampleWebApplication/out ./
ENTRYPOINT ["dotnetapp.exe"]
