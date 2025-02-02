<script setup>
import 'vue3-carousel/carousel.css';
import { computed, onMounted, onUnmounted, ref, watch } from "vue";
import { Carousel, Slide, Pagination, Navigation } from 'vue3-carousel';

/*const carouselConfig = {
  dir: 'ttb',
  wrapAround: true,
  itemsToShow: 2,
  snapAlign: 'center',
  height: '1000px',
  gap: 5,
};*/
const props=defineProps({
  Config: {
    type: Object, // Definir que es un array
    required: true, // Si no es obligatorio
  },Images: {
    type: Array, // Definir que es un array
    required:false,
     default: () => [],
  },
  
});
const Pictures = Array.from({ length: 10 }, (_, index) => ({
  id: index + 1,
  path: `https://picsum.photos/800/600?random=${index + 1}`,
}));
const carouselImages = computed(() => (props.Images.length ?props.Images : Pictures));
</script>

<template>
  <Carousel v-bind="Config">
    <Slide v-for="img in carouselImages" :key="img.id">
        <img :src="img.path" />
    </Slide>

    <template #addons>
      <Navigation />
      <Pagination />
    </template>
  </Carousel>
</template>