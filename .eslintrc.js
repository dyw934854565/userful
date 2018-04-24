module.exports = {
  env: {
    browser: true,
    es6: true
  },
  plugins: ["babel"],
  extends: "airbnb",
  parserOptions: {
    ecmaVersion: 8,
    ecmaFeatures: {
      experimentalObjectRestSpread: true
    },
    sourceType: "module"
  },
  parser: "babel-eslint",
  rules: {
    "babel/new-cap": 1,
    indent: 0,
    "linebreak-style": ["error", "windows"],
    quotes: ["error", "single"],
    semi: ["error", "always"],
    "no-case-declarations": 0,
    "no-unreachable": 0,
    "no-empty": 0,
    "no-debugger": 0,
    "no-console": 1,
    "no-unused-vars": 0, // 与装饰器冲突而关闭
    "no-var": 2,
    "jsx-a11y/href-no-hash": 0,
    radix: 0,
    "no-plusplus": 0,
    eqeqeq: 1,
    "no-shadow": 1,
    "no-mixed-operators": 1,
    "no-await-in-loop": 1,
    "no-mixed-operators": [
      "error",
      {
        allowSamePrecedence: true
      }
    ],
    "max-len": [1, 200],
    "no-bitwise": [
      "error",
      {
        int32Hint: true
      }
    ],
    "no-param-reassign": 1,
    "consistent-return": 1,
    "no-mixed-operators": 1,
    "import/no-extraneous-dependencies": 1,
    "import/no-named-as-default": 1,
    camelcase: 1,
    "no-restricted-properties": 1,
    "no-continue": 1,
    "max-statements": ["warn", 40],
    "max-params": ["warn", 4]
  }
};
