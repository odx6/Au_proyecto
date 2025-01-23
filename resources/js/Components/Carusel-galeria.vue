<script setup>
import 'vue3-carousel/carousel.css';
import { Carousel, Slide, Navigation } from 'vue3-carousel';
import { ref } from 'vue';

const currentSlide = ref(0);

const slideTo = (nextSlide) => (currentSlide.value = nextSlide);

const galleryConfig = {
  itemsToShow: 1,
  wrapAround: true,
  slideEffect: 'fade',
  mouseDrag: false,
  touchDrag: false,
  height: 320,
};

const thumbnailsConfig = {
  height: 80,
  itemsToShow: 6,
  wrapAround: true,
  touchDrag: false,
  gap: 10,
};

const images = Array.from({ length: 10 }, (_, index) => ({
  id: index + 1,
  url: `https://picsum.photos/800/600?random=${index + 1}`,
}));
</script>

<template>
  <Carousel id="gallery" v-bind="galleryConfig" v-model="currentSlide">
    <Slide v-for="image in images" :key="image.id">
      <img :src="image.url" alt="Gallery Image" class="gallery-image" />
    </Slide>
  </Carousel>

  <Carousel id="thumbnails" v-bind="thumbnailsConfig" v-model="currentSlide">
    <Slide v-for="image in images" :key="image.id">
      <template #default="{ currentIndex, isActive }">
        <div
          :class="['thumbnail', { 'is-active': isActive }]"
          @click="slideTo(currentIndex)"
        >
          <img :src="image.url" alt="Thumbnail Image" class="thumbnail-image" />
        </div>
      </template>
    </Slide>

    <template #addons>
      <Navigation />
    </template>
  </Carousel>
</template>
