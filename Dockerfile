# start from a clean base image (replace <version> with the desired release)
FROM runpod/worker-comfyui:5.1.0-base

# install custom nodes using comfy-cli (not required for Qwen-Image-Edit; native in ComfyUI)
# RUN comfy-node-install <your_custom_nodes_here>

# download models using comfy-cli
# the "--filename" is what you use in your ComfyUI workflow

# Text encoder (Qwen2.5-VL 7B, FP8 scaled)
RUN comfy model download --url "https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors?download=true" \
  --relative-path models/text_encoders \
  --filename qwen_2.5_vl_7b_fp8_scaled.safetensors

# VAE for Qwen-Image/Qwen-Image-Edit
RUN comfy model download --url "https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors?download=true" \
  --relative-path models/vae \
  --filename qwen_image_vae.safetensors

# Qwen-Image-Edit diffusion model — full 2509 BF16
RUN comfy model download --url "https://huggingface.co/Comfy-Org/Qwen-Image-Edit_ComfyUI/resolve/main/split_files/diffusion_models/qwen_image_edit_2509_bf16.safetensors?download=true" \
  --relative-path models/diffusion_models \
  --filename qwen_image_edit_2509_bf16.safetensors

# Qwen-Image Lightning LoRA (4 steps, V1.0)
RUN comfy model download --url "https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Lightning-4steps-V1.0.safetensors?download=true" \
  --relative-path models/loras \
  --filename Qwen-Image-Lightning-4steps-V1.0.safetensors

# (Optional) Copy local static input files into the ComfyUI input directory.
# Disabled because the repo has no ./input folder; the COPY step fails if it doesn't exist.
# To enable, create ./input and uncomment the line below.
# COPY input/ /comfyui/input/

# Ensure the input directory exists at runtime (the worker will upload to this dir).
RUN mkdir -p /comfyui/input
