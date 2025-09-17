@props(['active' => false])

<a class="{{ $active ? 'bg-gray-900 text-white': 'text-gray-300 hover:bg-white/5 hover:text-white'}} px-3 py-2 text-base font-medium text-white"
    aria-current="{{ $active ? 'page' : 'false' }}"
    {{ $attributes }}
>{{ $slot }}</a>