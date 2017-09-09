package com.ars;

import com.ars.generated.Company;
import com.ars.parser.XmlManager;



/**
 * Hello world!
 *
 */
public class App {
	private static final String BOOKSTORE_XML = App.class.getResource("/parse.xml").getFile();

	public static void main(String[] args) throws Exception {
		XmlManager manager=new XmlManager(BOOKSTORE_XML).initialize();
		Company company = (Company) manager.readXml();
		company.getStaff().stream().map(s->s.getNickname()).forEach(System.out::println);
	}
}