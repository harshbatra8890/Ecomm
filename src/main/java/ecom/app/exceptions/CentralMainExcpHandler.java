package ecom.app.exceptions;

import java.io.IOException;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class CentralMainExcpHandler {

	@ExceptionHandler(NullPointerException.class)
	@ResponseStatus(code = HttpStatus.INTERNAL_SERVER_ERROR)
	public ModelAndView handleNPE(NullPointerException ex) {
		System.out.println("\n Inside handleNullPointerException");
		ModelAndView modelAndView = new ModelAndView();
		ex.printStackTrace();
		modelAndView.setViewName("error");
		modelAndView.addObject("message", ex.getMessage());
		return modelAndView;
	}

	@ExceptionHandler(value = { IOException.class, EmptyResultDataAccessException.class })
	@ResponseStatus(code = HttpStatus.NOT_FOUND)
	public ModelAndView handleNOTFoundExcps(Exception ex) {
		System.out.println("\n Inside handleNOTFoundExcps");
		ModelAndView modelAndView = new ModelAndView();
		ex.printStackTrace();

		modelAndView.setViewName("error");
		modelAndView.addObject("message", ex.getMessage());
		return modelAndView;
	}

	@ExceptionHandler(Exception.class)
	@ResponseStatus(code = HttpStatus.NOT_FOUND)
	public ModelAndView handleExcps(Exception ex) {
		System.out.println("\n Inside handleExcps");
		ModelAndView modelAndView = new ModelAndView();
		ex.printStackTrace();

		modelAndView.setViewName("error");
		modelAndView.addObject("message", ex.getMessage());
		return modelAndView;
	}
}