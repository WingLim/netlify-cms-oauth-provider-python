FROM python:3.7-alpine as builder

RUN apk add --no-cache gcc g++ python-dev linux-headers libffi-dev openssl-dev

COPY requirements.txt /

RUN pip3 install --no-cache-dir -r requirements.txt 

FROM python:3.7-alpine

ENV RUN_HOST="0.0.0.0" \
    RUN_PORT=80

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY . /usr/src/app

COPY --from=0 /usr/local/lib/python3.7/site-packages /usr/local/lib/python3.7/site-packages

EXPOSE 80

ENTRYPOINT ["python3"]

CMD ["main.py"]
