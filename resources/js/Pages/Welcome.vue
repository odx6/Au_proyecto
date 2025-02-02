<script setup>

import Carrusel from "@/Components/Carusel-horizontal.vue";
import Carrusel1 from "@/Components/Carusel-alrededor.vue";
import Carrusel2 from "@/Components/Carusel-vertical.vue";
import Carrusel3 from "@/Components/Carusel-galeria.vue";
import Carrusel4 from "@/Components/Carusel-automatico.vue";


const galleryConfig = {
  itemsToShow: 1,
  wrapAround: true,
  slideEffect: "fade",
  mouseDrag: false,
  touchDrag: false,
  height:'500px',
};
const thumbnailsConfig = {
  height: '200px',
  itemsToShow: 2,
  wrapAround: true,
  touchDrag: false,
  gap: 10,
};
const config = {
  height: 'auto',
  itemsToShow: 1,
  gap: 5,
  wrapAround: true,
};
const configAutomatico = {
  height: 'auto',
  itemsToShow: 2,
  gap: 5,
  autoplay: 4000,
  wrapAround: true,
  pauseAutoplayOnHover: true,
};
const configHorizontal = {
  height: "100%",
  itemsToShow: 2,
  gap: 5,
};
const carouselConfig = {
  dir: "ttb",
  wrapAround: true,
  itemsToShow: 2,
  snapAlign: "center",
  height: "100%",
  gap: 5,
};
defineProps({
  canLogin: {
    type: Boolean,
  },
  canRegister: {
    type: Boolean,
  },
  laravelVersion: {
    type: String,
    required: true,
  },
  phpVersion: {
    type: String,
    required: true,
  },
  Images: {
    type: Array,
    required: true,
  },
  Configuracion: {
    type:Object,
    required: true,
  },
  
});

function handleImageError() {
  document.getElementById("screenshot-container")?.classList.add("!hidden");
  document.getElementById("docs-card")?.classList.add("!row-span-1");
  document.getElementById("docs-card-content")?.classList.add("!flex-row");
  document.getElementById("background")?.classList.add("!hidden");
}
</script>

<template>
  
  
  <div class="h-screen w-full bg-gray-100 flex items-center justify-center">
  <div  class="relative w-full h-full overflow-hidden">
 
    <Carrusel :Config="configHorizontal" :Images="Images" v-if="Configuracion.style==0"  ></Carrusel>
    <Carrusel1 :Config="config" :Images="Images" v-if="Configuracion.style==1"  ></Carrusel1>
    <Carrusel2 :Config="carouselConfig" :Images="Images" v-if="Configuracion.style==2"  ></Carrusel2>
    <Carrusel3 :Config="galleryConfig"
              :thumbnailsConfig="thumbnailsConfig" :Images="Images" v-if="Configuracion.style==3"  ></Carrusel3>
    <Carrusel4 :Config="configAutomatico" :Images="Images" v-if="Configuracion.style==4"  ></Carrusel4>
  
  </div>
</div>
</template>
