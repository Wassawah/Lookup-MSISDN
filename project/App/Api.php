<?php
namespace App\Api;

class Api
{
    public $app;

    public function __construct()
    {
        require '../vendor/autoload.php';
        $this->app = new \Slim\Slim();
        $this->app->response()->header("Content-Type", "application/json");
        $this->app->get('/', array($this, 'index'));
        $this->app->get('/:number', array($this, 'jsonMsisdn'));
    }

    public function responseStatus($code)
    {
        $this->app->response()->status($code);
    }
    public function jsonMsisdn($number)
    {
        $lookup = new \App\Lookup("../");
        $info = $lookup->msisdn($number);
        $success = $lookup->checkSuccess();
        $arrayData['status'] = $success;
        $arrayData['data'] = $info;
        
        if ($success === 'fail') {
            $arrayData['error'] = $lookup->error['msg'];
            $this->responseStatus($lookup->error['code']);
        } else {
            $this->responseStatus(200);
        }
        $data = json_encode($arrayData);
        print_r($data);
    }
    public function index()
    {
        $data['status'] = "Fail";
        $data['error'] = "No input";
        $data = json_encode($data);
        print_r($data);
        $this->responseStatus(200);
    }
    public function init()
    {
        $this->app->run();
    }
}
