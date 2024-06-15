## FIRST STAGE ##
FROM ubuntu as build
RUN apt-get update && apt-get install -y golang-go
ENV GO111MODULE=off
COPY . .
RUN CGO_ENABLED=0 go build -o /app .

## SECOND STAGE ##

## USING DISTROLESS DOCKER IMAGE FOR GO LANG https://github.com/GoogleContainerTools/distroless
FROM SCRATCH
## Copy the compiled binary from the above build stage
COPY --from=build /app /app
ENTRYPOINT ["/app"]