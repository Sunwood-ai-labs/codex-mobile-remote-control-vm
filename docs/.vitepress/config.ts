import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'Codex Mobile Remote Control VM',
  description: 'Codex Skill for mobile remote control of Ubuntu VM-hosted Codex Desktop.',
  base: '/codex-mobile-remote-control-vm/',
  cleanUrls: true,
  head: [
    ['link', { rel: 'icon', href: '/codex-mobile-remote-control-vm/logo.svg' }],
    ['meta', { property: 'og:title', content: 'Codex Mobile Remote Control VM' }],
    ['meta', { property: 'og:description', content: 'Set up Ubuntu VMs that can be controlled from the ChatGPT/Codex mobile app.' }],
    ['meta', { property: 'og:type', content: 'website' }]
  ],
  themeConfig: {
    logo: '/logo.svg',
    search: {
      provider: 'local'
    },
    nav: [
      { text: 'Guide', link: '/guide/getting-started' },
      { text: 'Release', link: '/guide/releases/v0.1.0' },
      { text: '日本語', link: '/ja/' },
      { text: 'GitHub', link: 'https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm' }
    ],
    sidebar: {
      '/guide/': [
        {
          text: 'Guide',
          items: [
            { text: 'Getting Started', link: '/guide/getting-started' },
            { text: 'Usage', link: '/guide/usage' },
            { text: 'Troubleshooting', link: '/guide/troubleshooting' },
            { text: 'v0.1.0 Release Notes', link: '/guide/releases/v0.1.0' },
            { text: 'Mobile Control Walkthrough', link: '/guide/articles/mobile-remote-control-vm-v0.1.0' }
          ]
        }
      ],
      '/ja/guide/': [
        {
          text: 'ガイド',
          items: [
            { text: 'はじめに', link: '/ja/guide/getting-started' },
            { text: '使い方', link: '/ja/guide/usage' },
            { text: 'トラブルシュート', link: '/ja/guide/troubleshooting' },
            { text: 'v0.1.0 リリースノート', link: '/ja/guide/releases/v0.1.0' },
            { text: 'スマホ制御ウォークスルー', link: '/ja/guide/articles/mobile-remote-control-vm-v0.1.0' }
          ]
        }
      ]
    },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm' }
    ],
    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright 2026 Sunwood-ai-labs'
    }
  },
  locales: {
    root: {
      label: 'English',
      lang: 'en-US'
    },
    ja: {
      label: '日本語',
      lang: 'ja-JP',
      link: '/ja/',
      themeConfig: {
        nav: [
          { text: 'ガイド', link: '/ja/guide/getting-started' },
          { text: 'リリース', link: '/ja/guide/releases/v0.1.0' },
          { text: 'English', link: '/' },
          { text: 'GitHub', link: 'https://github.com/Sunwood-ai-labs/codex-mobile-remote-control-vm' }
        ]
      }
    }
  }
})
