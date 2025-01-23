<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Carrusel from '@/Components/Carusel-horizontal.vue';
import Carrusel2 from '@/Components/Carusel-alrededor.vue';
import Carrusel3 from '@/Components/Carusel-vertical.vue';
import Carrusel4 from '@/Components/carusel-automatico.vue';
import Carrusel5 from '@/Components/Carusel-galeria.vue';
import { Head } from '@inertiajs/vue3';
</script>

<template>
    <Head title="Dashboard" />

    <AuthenticatedLayout>
        <template #header>
            <h2
                class="text-xl font-semibold leading-tight text-gray-800"
            >
                Dashboard
            </h2>
        </template>

        <div class="py-12">
            <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
                <div
                    class="overflow-hidden bg-white shadow-sm sm:rounded-lg"
                >
                   <Carrusel></Carrusel>
                   <Carrusel2></Carrusel2>
                   <Carrusel3></Carrusel3>
                   <Carrusel4></Carrusel4>
                   <Carrusel5></Carrusel5>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
