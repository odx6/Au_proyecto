<script setup>
import "vue3-carousel/carousel.css";
import { Carousel, Slide, Navigation } from "vue3-carousel";
import { ref, computed } from "vue";

const currentSlide = ref(0);

const slideTo = (nextSlide) => (currentSlide.value = nextSlide);
const props=defineProps({
  Config: {
    type: Object, // Definir que es un array
    required: true, // Si no es obligatorio
  },
  thumbnailsConfig: {
    type: Object, // Definir que es un array
    required: true, // Si no es obligatorio
  },
  Images: {
    type: Array,
    required: false, // Lo hacemos opcional
    default: () => [], // Valor por defecto como array vacío
  },
});

const Pictures = Array.from({ length: 10 }, (_, index) => ({
  id: index + 1,
  path: `https://picsum.photos/800/600?random=${index + 1}`,
}));
const carouselImages = computed(() =>
  props.Images.length
    ? props.Images.map((image) => ({
        id: image.id,
        path: image.path.startsWith("http") ? image.path : `/storage/${image.path}`,
      }))
    : Pictures
);
</script>

<template>
  <Carousel id="gallery" v-bind="Config" v-model="currentSlide">
    <Slide v-for="image in carouselImages" :key="image.id">
      <img :src="image.path" alt="Gallery Image" class="gallery-image" />
    </Slide>
  </Carousel>

  <Carousel id="thumbnails" v-bind="thumbnailsConfig" v-model="currentSlide">
    <Slide v-for="image in carouselImages" :key="image.id">
      <template #default="{ currentIndex, isActive }">
        <div
          :class="['thumbnail', { 'is-active': isActive }]"
          @click="slideTo(currentIndex)"
        >
          <img
            :src="image.path"
            alt="Thumbnail Image"
            class="thumbnail-image"
          />
        </div>
      </template>
    </Slide>

    <template #addons>
      <Navigation />
    </template>
  </Carousel>
</template>
