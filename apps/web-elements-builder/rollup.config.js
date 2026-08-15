import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import { terser } from 'rollup-plugin-terser';

export default {
  input: 'apps/web-elements-builder/src/main.js',
  output: [
    {
      file: 'dist/web-elements.bundle.js',
      format: 'iife',
      name: 'WebElements'
    },
    {
      file: 'dist/web-elements.esm.js',
      format: 'es'
    }
  ],
  plugins: [resolve(), commonjs(), terser()]
};
