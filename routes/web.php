<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ImageController;
use App\Http\Controllers\ConfiguracionController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;

use Inertia\Inertia;

Route::get('/', function () {
    $id=1;
    $Images = \App\Models\Image::all();
    $Config = \App\Models\Configuracion::findOrFail($id);;
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
        'Images' => $Images,
        'Configuracion' => $Config
    ]);
});

Route::get('/dashboard', function () {
    $Images = \App\Models\Image::all();
    return Inertia::render('Dashboard',['Images' => $Images,]);
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});
 
Route::middleware('auth')->group(function () {
    Route::get('/imagenes', [ImageController::class, 'index'])->name('create.img');
    Route::post('Image', [ImageController::class, 'store'])->name('images.store');
    Route::delete('Image', [ImageController::class, 'destroy'])->name('images.destroy');
});
Route::middleware('auth')->group(function () {
    Route::put('/dasboard', [ConfiguracionController::class, 'update'])->name('configuracion.update');
   
});
require __DIR__.'/auth.php';
