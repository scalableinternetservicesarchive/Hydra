// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import React from 'react';
import { createRoot } from 'react-dom/client';
import HelloMessage from './App';

const container = document.getElementById('root');
const root = createRoot(container);

document.addEventListener('DOMContentLoaded', () => {
  root.render(<HelloMessage name="World" />);
});