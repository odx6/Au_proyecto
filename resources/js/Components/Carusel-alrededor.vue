<script setup>
import "vue3-carousel/dist/carousel.css";
import { computed, onMounted, onUnmounted, ref, watch } from "vue";
import { Carousel, Slide, Pagination, Navigation } from "vue3-carousel";

const  Pictures = Array.from({ length: 10 }, (_, index) => ({
  id: index + 1,
  path: `https://picsum.photos/800/600?random=${index + 1}`,
}));
const props=defineProps({
  Config: {
    type: Object, // Definir que es un array
    required: true, // Si no es obligatorio
  },
  Images: {
    type: Array,
    required: false, // Lo hacemos opcional
    default: () => [], // Valor por defecto como array vacío
  },
  
});
const carouselImages = computed(() => (props.Images.length ?props.Images : Pictures));
/*
const config = {
  height: 200,
  itemsToShow: 2,
  gap: 5,
  wrapAround: true,
};*/
</script>

<template>
  <Carousel v-bind="Config">
    <Slide v-for="image in carouselImages" :key="image.id">
      <img :src="image.path" alt="image" />
    </Slide>
    <template #addons>
      <Navigation />
    </template>
  </Carousel>
</template>