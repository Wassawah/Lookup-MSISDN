# Lookup-MSISDN

Lookup-MSISDN is simple REST api.

## Setup

Need:
[Vagrant](http://vagrantup.com) and [VirtualBox](http://virtualbox.org)

Install:
vagrant up

## Usage

http://127.0.0.1:8080/api:number

get error if :number null

get no content if :number is not msisdn number

### Example:

http://127.0.0.1:8080/api/0038640544650

json return:
{
  status: "success"
  data: {
    id: "1149"
    ndc: "40"
    ISO: "si"
    country: "Slovenia"
    country_code: "386"
    network: "SI.Mobil"
    numberDetail: "386 544650"
    Subscribe: "544650"
    number: "38640544650"
  }-
}

