import React, {useState, useEffect} from "react";

import Header from "../ui/Header";
import Footer from "../ui/Footer";
import HelpersNav from "../ui/HelpersNav";
import HelpersList from "./HelpersList";
import HelpersAdd from "./HelpersAdd";
import HelpersLocation from "./HelpersLocation";


const Helpers = () => {
    const [loginData, setLoginData] = useState("");
    const [currentPage, setCurrentPage] = useState("location");
    const [btnColor1,setBtnColor1] = useState("#999");
    const [btnColor2,setBtnColor2] = useState("#999");
    const [btnColor3,setBtnColor3] = useState("#999");
    useEffect(() => {
        // 컴포넌트가 처음 렌더링될 때 실행되는 코드
        const storedLoginData = sessionStorage.getItem("loginData");
        if (storedLoginData) {
            // 로컬 스토리지에 로그인 데이터가 있으면 로그인 상태를 업데이트
            setLoginData(storedLoginData);
        } else {
            // 로컬 스토리지에 로그인 데이터가 없으면 로그인 페이지로 리다이렉트
            window.location.href = "/"; // 로그인 페이지의 경로에 따라 변경
        }
    }, []); // 빈 배열을 전달하여 처음 렌더링될 때만 실행되도록 설정

    // 페이지 변경 핸들러
    const handlePageChange = (pageName) => {
        setCurrentPage(pageName);
    };

    // 현재 페이지 렌더링
    useEffect(() => {
        switch (currentPage) {
            case "list":
                setBtnColor3("#999");
                setBtnColor2("#999");
                setBtnColor1("#ff578b");
                break;
            case "add":
                setBtnColor3("#999");
                setBtnColor2("#ff578b");
                setBtnColor1("#999");
                break;
            case "location":
                setBtnColor3("#ff578b");
                setBtnColor2("#999");
                setBtnColor1("#999");
                break;
            default:
                break;
        }
    }, [currentPage]);

    return (
        <>

            <Header/>
            <HelpersNav onPageChange={handlePageChange} btnColor1={btnColor1} btnColor2={btnColor2} btnColor3={btnColor3} />
            <div>아니: {loginData}</div>

            {/* 현재 페이지에 따른 컴포넌트 렌더링 */}
            {currentPage === "list" && <HelpersList />}
            {currentPage === "add" && <HelpersAdd />}
            {currentPage === "location" && <HelpersLocation loggedInUserProps={loginData} />}

            <Footer color1="#999" color2="#ff578b" color3="#999" color4="#999"/>

        </>
    );
}

export default Helpers;