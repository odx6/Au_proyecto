<?php

namespace App\Http\Controllers;
use App\Models\Image;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Storage;

class ImageController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('Add-imagen', [
            'images' => Image::all(),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
   /* public function store(Request $request)
    {
        //
    }*/
    public function store(Request $request){
    $request->validate([
        'name' => 'required|string|max:255',
        'image' => 'required|image|mimes:jpg,jpeg,png|max:2048',
    ]);

    $imageFile = $request->file('image');

    // Obtener dimensiones de la imagen
    list($width, $height) = getimagesize($imageFile);

    // Guardar la imagen en el almacenamiento público
    $path = $imageFile->store('images', 'public');

    // Guardar los datos en la base de datos
    $image = Image::create([
        'name' => $request->name,
        'path' => $path,
        'mime_type' => $width,
        'size' => $height,
    ]);
    return redirect(route('create.img', absolute: false));

    //return response()->json($image, 201);
}
    /**
     * Display the specified resource.
     */
    public function show(Image $image)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Image $image)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Image $image)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request)
    {     
        $id= $request->id;
        $image = Image::findOrFail($id);

        // Eliminar el archivo de imagen del almacenamiento
        if ($image->path && Storage::disk('public')->delete($image->path)) {
            Storage::disk('public')->delete($image->path);
            $message='Imagen eliminada con éxito{$image->path}';
        }else{
            $message='Imagen eliminada con éxito, pero no se encontró en el almacenamiento{$image->path}';
        }
    
        // Eliminar el registro de la base de datos
        $image->delete();
    
        return redirect()->route('create.img')->with('success', $message);
    }
}
