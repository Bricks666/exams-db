import typescript from "rollup-plugin-typescript2";
import commonjs from "@rollup/plugin-commonjs";
import resolve from "@rollup/plugin-node-resolve";
import url from "@rollup/plugin-url";

/** @type {import("rollup").RollupOptions} */
export default {
  input: "./src/index.ts",
  external: [/node_modules/, /.json/],
  output: {
    file: "./dist/index.js",
    format: "esm",
    exports: "named",
  },

  plugins: [
    resolve({
      preferBuiltins: true,
    }),
    commonjs(),
    typescript({
      tsconfig: "tsconfig.json",
    }),
    url({
      include: ["**/*.sql"],
      limit: 0,
      fileName: "[dirname][name][extname]",
    }),
  ],
};
