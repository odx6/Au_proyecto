<script setup>
import 'vue3-carousel/carousel.css';
import { Carousel, Slide, Pagination, Navigation } from 'vue3-carousel';

const images = Array.from({ length: 10 }, (_, index) => ({
  id: index + 1,
  url: `https://picsum.photos/800/600?random=${index + 1}`,
}));

const config = {
  height: 200,
  itemsToShow: 2,
  gap: 5,
};
</script>

<template>
  <Carousel v-bind="config">
    <Slide v-for="image in images" :key="image.id">
      <img :src="image.url" alt="image" />
    </Slide>

    <template #addons>
      <Navigation />
      <Pagination />
    </template>
  </Carousel>
</template>