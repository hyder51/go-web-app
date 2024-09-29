FROM golang:1.22 as base

WORKDIR /app

## It will copy the dependencies to the /app and go.mod is as same as pom.xml for java ##

COPY go.mod .  

## This will download the dependencies will act as pip install -r requirements.txt as same in python##

RUN go mod download  

COPY . .

## IT should be run when we are in the /app folder ##

RUN go build -o main  

## EXPOSE 8080   ##This can be done in single stage docker file##

## CMD [ "./main" ]  ##This can be done in single stage docker file##

###---FINAL STAGE FROM DISTROLESS IMAGE---###

FROM gcr.io/distroless/base

COPY --from=base /app/main . 

##This will copy html files css files because static content is outside binary##

COPY --from=base /app/static ./static  

EXPOSE 8080

CMD [ "./main" ]
