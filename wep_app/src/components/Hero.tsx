import Image from 'next/image'


export default function Hero() {
    return (
                <div className="container flex flex-col justify-center p-6 mx-auto sm:py-12 lg:py-24 lg:flex-row lg:justify-between">
                    <div className="flex items-center justify-center p-6 mt-8 lg:mt-0 h-72 sm:h-80 lg:h-96 xl:h-112 2xl:h-128">
                        <img src="/bridge.png" alt="" className="object-contain h-72 sm:h-80 lg:h-96 xl:h-112 2xl:h-128" />
                    </div>
                    <div className="flex flex-col justify-center p-6 text-center rounded-sm lg:max-w-md xl:max-w-lg lg:text-left">
                        <h1 className="text-5xl font-bold leadi sm:text-6xl">Invest from one Chain
                            <span className="dark:text-violet-400"></span>
                        </h1>
                        <p className="mt-6 mb-8 text-lg sm:mb-12">Use one Crypto network to invest in any other network
                            <br className="hidden md:inline lg:hidden" />
                        </p>
                    </div>
                </div>
    )
}