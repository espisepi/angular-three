import * as THREE from 'three';

class VanillaThreeElement extends HTMLElement {
  constructor() {
    super();
    this._root = this.attachShadow({ mode: 'open' });
    this._container = document.createElement('div');
    this._container.style.width = '400px';
    this._container.style.height = '300px';
    this._root.appendChild(this._container);
  }

  connectedCallback() {
    const width = 400;
    const height = 300;
    this._scene = new THREE.Scene();
    this._camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000);
    this._renderer = new THREE.WebGLRenderer({ antialias: true });
    this._renderer.setSize(width, height);
    this._container.appendChild(this._renderer.domElement);

    const geometry = new THREE.BoxGeometry();
    const material = new THREE.MeshBasicMaterial({ color: 0x00ff00 });
    this._cube = new THREE.Mesh(geometry, material);
    this._scene.add(this._cube);
    this._camera.position.z = 5;

    this._animate = this._animate.bind(this);
    this._running = true;
    requestAnimationFrame(this._animate);
  }

  disconnectedCallback() {
    this._running = false;
    if (this._renderer) {
      this._renderer.dispose();
    }
  }

  _animate() {
    if (!this._running) return;
    this._cube.rotation.x += 0.01;
    this._cube.rotation.y += 0.01;
    this._renderer.render(this._scene, this._camera);
    requestAnimationFrame(this._animate);
  }
}

if (!customElements.get('three-element')) {
  customElements.define('three-element', VanillaThreeElement);
}

export default VanillaThreeElement;
