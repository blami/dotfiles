// ~/.hyper.js - hyper terminal configuration

module.exports = {
  config: {
    // Shell
    shell: 'ubuntu1804.exe',
    shellArgs: [],
    defaultSSHApp: true,

    // Environment
    env: {
      'HYPERJS': '1',
    },

    // Misc
    scrollback: 4096,
    updateChannel: 'stable',

    // Font
    fontSize: 12,
    fontFamily: '"Go Mono", monospace',
    fontWeight: 'normal',
    fontWeightBold: 'bold',

    cursorShape: 'BLOCK',
    cursorBlink: false,
    copyOnSelect: true,

    foregroundColor: '#f8f8f2',
    backgroundColor: '#282a36',
    selectionColor: '#5af78e',
    cursorColor: '#5af78e',
    cursorAccentColor: '#000',

    colors: {
      black: '#000000',
      red: '#ff5555',
      green: '#50fa7b',
      yellow: '#f1fa8c',
      blue: '#bd93f9',
      magenta: '#ff79c6',
      cyan: '#8be9fd',
      white: '#bfbfbf',
      lightBlack: '#4d4d4d',
      lightRed: '#ff6e67',
      lightGreen: '#5af78e',
      lightYellow: '#f4f99d',
      lightBlue: '#caa9fa',
      lightMagenta: '#ff92d0',
      lightCyan: '#9aedfe',
      lightWhite: '#e6e6e6',
    },

    borderColor: '#282a36',

    css: '',
    termCSS: '',
    padding: '12px 14px',

    showHamburgerMenu: '',
    showWindowControls: '',

    // Bell
    bell: 'SOUND',
    //bellSoundURL: 'http://example.com/bell.mp3',
  },

  // Keymaps
  keymaps: {
  },

  // Plugins
  plugins: [],
  localPlugins: [],
};
