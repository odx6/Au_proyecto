<script setup>
import 'vue3-carousel/carousel.css';
import { Carousel, Slide, Pagination, Navigation } from 'vue3-carousel';
import { computed, onMounted, onUnmounted, ref, watch } from "vue";
const Pictures = Array.from({ length: 10 }, (_, index) => ({
  id: index + 1,
  path: `https://picsum.photos/800/600?random=${index + 1}`,
}));
const props=defineProps({
  Config: {
    type: Object, // Definir que es un array
    required: true, // Si no es obligatorio
  }, Images: {
    type: Array,
    required: false, // Lo hacemos opcional
    default: () => [], // Valor por defecto como array vacío
  },
});
const carouselImages = computed(() =>
  props.Images.length
    ? props.Images.map((image) => ({
        id: image.id,
        path: image.path.startsWith("http") ? image.path : `/storage/${image.path}`,
      }))
    : Pictures
);
/*const config = {
  height: 960,
  itemsToShow: 2,
  gap: 5,
};*/
</script>

<template>
  <Carousel v-bind="Config">
    <Slide v-for="image in carouselImages" :key="image.id">
      <img :src="image.path" alt="image" />
    </Slide>

    <template #addons>
      <Navigation />
      <Pagination />
    </template>
  </Carousel>
</template>