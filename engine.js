#!/usr/bin/env node
import fs from 'fs'
import { spawn } from 'child_process'
import chalk from 'chalk'
import r from 'readline'
const log = console.log
const rl = r.createInterface({input:process.stdin,output:process.stdout});
const wait = (ms) => { return new Promise(r => setTimeout(r,ms));}
const clear = () => { spawn('clear',{stdio:"inherit"});}
async function engine(){
	clear();
	await wait(450);
	await log(chalk.red.bold(fs.readFileSync('./src/logo','utf8')));
	await log(chalk.gray.bold());
	await log(chalk.bold(`Please select your WhatsApp type

${chalk.red.bold('[01]')} WhatsApp Original
${chalk.red.bold('[02]')} WhatsApp Business

${chalk.red.bold("Don't choose WhatsApp Business")}
${chalk.red.bold("if you are using the original WhatsApp")}
	`));
	await wait(200);
	rl.question(chalk.gray.bold('Select your WhatsApp type : '),(type)=>{
		switch(type){
			case '01':
			case '1':
				exec('./engine/waori.rb');
				break;
			case '02':
			case '2':
				exec('./engine/wabis.rb');
				break;
			default:
			notfound();
		}
	});
} engine();
async function notfound(){
	await log(chalk.red.bold('Options not available'));
	await wait(1000);
	await engine();
} function exec(rub){
	const child = spawn('ruby',[rub],{stdio:'inherit'});
	child.on('close',() => {
		process.exit(0);
	});
}
