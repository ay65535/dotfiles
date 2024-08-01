FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    # curl \
    # git \
    # zsh \
    # vim \
    sudo \
    # build-essential \
    && rm -rf /var/lib/apt/lists/*

# # Install Rust (needed for sheldon)
# RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# ENV PATH="/root/.cargo/bin:${PATH}"

# # Install dotter
# RUN curl -fsSL https://get.dotter.sh | sh

# # Install sheldon
# RUN cargo install sheldon

# # Install mise
# RUN curl https://mise.jdx.dev/install.sh | sh
# ENV PATH="/root/.local/bin:${PATH}"

# Create a test user
RUN useradd -m testuser && echo "testuser ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/testuser

# Switch to test user
USER testuser
WORKDIR /home/testuser

# Copy dotfiles into the container
COPY . /home/testuser/dotfiles

# # Set up entrypoint
# COPY docker-entrypoint.sh /docker-entrypoint.sh
# RUN sudo chmod +x /docker-entrypoint.sh

# ENTRYPOINT ["/docker-entrypoint.sh"]
