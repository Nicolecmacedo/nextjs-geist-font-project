import type { NextConfig } from 'next'

const nextConfig: NextConfig = {
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'images.pexels.com',
        pathname: '/photos/**',
      },
    ],
  },
  // Configurações de produção
  output: 'standalone', // Otimiza para deploy em produção
  poweredByHeader: false, // Remove o header X-Powered-By por segurança
  compress: true, // Habilita compressão Gzip
  productionBrowserSourceMaps: false, // Desabilita source maps em produção
  // Configuração do servidor
  experimental: {
    serverActions: {
      bodySizeLimit: '2mb'
    }
  },
  // Configuração da porta
  env: {
    PORT: '3000'
  }
}

export default nextConfig
