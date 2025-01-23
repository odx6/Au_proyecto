<script setup>
import 'vue3-carousel/carousel.css';
import { Carousel, Slide, Pagination, Navigation } from 'vue3-carousel';

const carouselConfig = {
  dir: 'ttb',
  wrapAround: true,
  itemsToShow: 2,
  snapAlign: 'center',
  height: '400px',
  gap: 5,
};

const images = Array.from({ length: 10 }, (_, index) => ({
  id: index + 1,
  url: `https://picsum.photos/800/600?random=${index + 1}`,
}));
</script>

<template>
  <Carousel v-bind="carouselConfig">
    <Slide v-for="img in images" :key="img.id">
        <img :src="img.url" />
    </Slide>

    <template #addons>
      <Navigation />
      <Pagination />
    </template>
  </Carousel>
</template>