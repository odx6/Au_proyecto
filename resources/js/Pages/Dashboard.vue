<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import Carrusel from "@/Components/Carusel-horizontal.vue";
import Carrusel2 from "@/Components/Carusel-alrededor.vue";
import Carrusel3 from "@/Components/Carusel-vertical.vue";
import Carrusel5 from "@/Components/Carusel-galeria.vue";
import Carrusel6 from "@/Components/Carusel-automatico.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import { Head, useForm } from "@inertiajs/vue3";
import { computed, onMounted, onUnmounted, ref, watch } from "vue";
const options = ref([false, false, false, false]);
const isDisabled = ref(false);
const galleryConfig = {
  itemsToShow: 1,
  wrapAround: true,
  slideEffect: "fade",
  mouseDrag: false,
  touchDrag: false,
  height: 50,
};
const thumbnailsConfig = {
  height: 50,
  itemsToShow: 2,
  wrapAround: true,
  touchDrag: false,
  gap: 10,
};
const config = {
  height: 50,
  itemsToShow: 1,
  gap: 5,
  wrapAround: true,
};
const configAutomatico = {
  height: 200,
  itemsToShow: 2,
  gap: 5,
  autoplay: 4000,
  wrapAround: true,
  pauseAutoplayOnHover: true,
};
const configHorizontal = {
  height: "50px",
  itemsToShow: 2,
  gap: 5,
};
const carouselConfig = {
  dir: "ttb",
  wrapAround: true,
  itemsToShow: 2,
  snapAlign: "center",
  height: "100px",
  gap: 5,
};
function toggleDisable(index) {
  const anySelected = options.value.some((option) => option);
  form.exclusive = index;
  if (anySelected) {
    isDisabled.value = true;
  } else {
    isDisabled.value = false;
  }
}
const form = useForm({
  exclusive: null,
});
const submit = () => {
  form.put(route("configuracion.update"), {
    preserveScroll: true,
    onSuccess: () => {
      form.reset(); // Resetear el formulario
    },
  });
};
defineProps({
  Images: {
    type: Array,
    required: true,
  },
  
  
});
</script>

<template>
  <Head title="Dashboard" />

  <AuthenticatedLayout>
    <template #header>
      <h2 class="text-xl font-semibold leading-tight text-gray-800">
        Estilo de modal
      </h2>
    </template>
  <div class="py-12">
    <form @submit.prevent="submit">
      <!-- Botón de Guardar -->
      <div class="mt-6 flex items-center justify-center">
        <PrimaryButton
          class="ms-4"
          :class="{ 'opacity-25': form.processing }"
          :disabled="form.processing" 
          
        >
          Guardar
        </PrimaryButton>
      </div>

      <!-- Contenedor principal con desplazamiento horizontal -->
      <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
        <div class="flex space-x-6 overflow-x-auto p-4">
          <!-- Carrusel 1 -->
          <div class="flex-1 min-w-[300px] bg-green shadow-sm sm:rounded-lg">
            <input
              type="checkbox"
              class="rounded text-pink-500"
              name="exclusive"
              value="1"
              v-model="options[0]"
              @change="toggleDisable(0)"
              :disabled="isDisabled && !options[0]"
            />
            <Carrusel :Config="configHorizontal" :Images="Images"></Carrusel>
          </div>

          <!-- Carrusel 2 -->
          <div class="flex-1 min-w-[300px] bg-green shadow-sm sm:rounded-lg">
            <input
              type="checkbox"
              class="rounded text-pink-500"
              name="exclusive"
              value="2"
              v-model="options[1]"
              @change="toggleDisable(1)"
              :disabled="isDisabled && !options[1]"
            />
            <Carrusel2 :Config="config" :Images="Images"></Carrusel2>
          </div>

          <!-- Carrusel 3 -->
          <div class="flex-1 min-w-[300px] bg-green shadow-sm sm:rounded-lg">
            <input
              type="checkbox"
              class="rounded text-pink-500"
              name="exclusive"
              value="3"
              v-model="options[2]"
              @change="toggleDisable(2)"
              :disabled="isDisabled && !options[2]"
            />
            <Carrusel3 :Config="carouselConfig" :Images="Images"></Carrusel3>
          </div>

          <!-- Carrusel 4 -->
          <div class="flex-1 min-w-[300px] bg-green shadow-sm sm:rounded-lg">
            <input
              type="checkbox"
              class="rounded text-pink-500"
              name="exclusive"
              value="4"
              v-model="options[3]"
              @change="toggleDisable(3)"
              :disabled="isDisabled && !options[3]"
            />
            <Carrusel5
              :Config="galleryConfig"
              :thumbnailsConfig="thumbnailsConfig"
              :Images="Images"
            ></Carrusel5>
          </div>

          <!-- Carrusel 5 -->
          <div class="flex-1 min-w-[300px] bg-green shadow-sm sm:rounded-lg">
            <input
              type="checkbox"
              class="rounded text-pink-500"
              name="exclusive"
              value="5"
              v-model="options[4]"
              @change="toggleDisable(4)"
              :disabled="isDisabled && !options[4]"
            />
            <Carrusel6 :Config="configAutomatico" :Images="Images"></Carrusel6>
          </div>
        </div>
      </div>
    </form>
  </div>
  </AuthenticatedLayout>
</template>
