<?php

namespace App\Http\Controllers;
use Illuminate\View\View;

class TesteController
{
    public function test()
    {
        //dd('aqui');
        return view('test');
    }
}