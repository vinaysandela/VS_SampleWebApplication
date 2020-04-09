#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see http://aka.ms/containercompat 

#FROM microsoft/aspnet:4.7.2-windowsservercore-1803
#ARG source
#WORKDIR /inetpub/wwwroot
#COPY ${source:-obj/Docker/publish} .
FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch as debug

#install debugger for NET Core
RUN apt-get update
RUN apt-get install -y unzip
RUN curl -sSL https://aka.ms/getvsdbgsh | /bin/sh /dev/stdin -v latest -l ~/vsdbg

RUN mkdir /work/
WORKDIR /work/

COPY ./SampleWebApplication/SampleWebApplication.csproj /work/SampleWebApplication.csproj
RUN dotnet restore

COPY ./SampleWebApplication/ /work/
RUN mkdir /out/
RUN dotnet publish --no-restore --output /out/ --configuration Release

ENTRYPOINT ["dotnet", "run"]

###########START NEW IMAGE###########################################

FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim as prod

RUN mkdir /app/
WORKDIR /app/
COPY --from=debug /out/ /app/
RUN chmod +x /app/ 
CMD dotnet work.dll
