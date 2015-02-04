<?php
namespace App;

class Lookup
{

    public function __construct($file = "/")
    {
        require_once($file . "App/DB.php");
        require_once($file . "App/Tools.php");
    }

    public $data;
    public $status = 'fail';
    public $error;

    public function checkSuccess()
    {
        return $this->status;
    }

    public function arrayFill($key, $value)
    {
        $this->data[$key] = $value;
    }

    public function msisdn($number)
    {
        //clean up the number
        $number = $this->cleanNumber($number);
        if ($number) {
            //connect to base via PDO
            $obj = new \App\Tools\Hammer();
            //first need to check what country is it, so first 3 numbers
            $obj->value = $number;
            $obj->checkQuery();

            $this->data = $obj->result;
            $obj->cleanUp();

            if (!empty($this->data)) {
                //check what network -> country code
                $contryCode = $this->data['country_code'];
                $obj->valueNdc = substr($number, $obj->modeID, 3);
                $obj->value = $contryCode;
                $obj->checkQuery();

                $returned = $obj->result;
                $obj->cleanUp();

                if (empty($returned)) {
                    $this->error = array('msg' => 'Unknown NDC', 'code' => 404);
                } else {
                    $this->status = 'success';
                    $this->data = $returned;
                    $subscribe = substr($number, $obj->modeID);
                    $this->data['numberDetail'] = $contryCode ." ". $this->data['ndc'] ." ". $subscribe;
                    $this->data['Subscribe'] = $subscribe;
                    $this->data['numberDetail'] = $contryCode ." ". $subscribe;
                }
            } else {
                $this->error = array('msg' => 'Unknown Country', 'code' => 404);
            }
        } else {
            $this->error = array('msg' => 'This is not a MSISDN?', 'code' => 204);
        }
        $this->arrayFill('number', $number);

        return $this->data;
    }

    public function cleanNumber($number)
    {
        //add sql inject perventor

        $number = $this->pregReplace('/\D/', '', $number); //allow only numbers
        $number = $this->pregReplace('/(^00)/', '', $number); //remove double zero
        //11 or 15 character is MSISDN!? So i could put that higher :D
        if (strlen($number) < 6) {
            return false;
        }
        return $number;
    }
    public function pregReplace($what, $with, $string)
    {
        return preg_replace($what, $with, $string);
    }
}
